//
//  ConsumeViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/22/24.
//

import Combine
import Moya
import SnapKit
import UIKit

class ConsumeViewController: UIViewController {
  // MARK: - Properties

  // View
  private var consumeView = ConsumeView()

  // ViewController
  private lazy var categorySelectTableViewController = CategorySelectTableViewController()
  private lazy var consumedHistoryTableViewController = ConsumedHistoryTableViewController()

  // Network
  private let provider = MoyaProvider<CategoryRouter>()

  // Combine
  private var cancellables = Set<AnyCancellable>()

  // Variable
  private var writtenConsumedPriceText = ""
  private var writtenConsumedContentText = ""
  private var selectedDate = Date()
  private var selectedCategory = ""

  // MARK: - View Life Cycle

  override func loadView() {
    view = consumeView
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setNavigation()
    setUITextFieldDelegate()
    setButtonAction()
    setDatePickerAction()
    observeSelectedCategory()
  }

  // MARK: - Methods

  private func setNavigation() {
    navigationItem.title = "소비 추가하기"
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "소비기록", image: UIImage(systemName: "list.clipboard"), target: self,
      action: #selector(rightBarButtonItemButtonTapped))

    navigationItem.backBarButtonItem = UIBarButtonItem()

    /*
     해야 할 일
     1. rightBarButtonItem의 색상을 Asset에 등록하고 사용하도록 설계
     */
    navigationItem.rightBarButtonItem?.tintColor = UIColor(
      red: 0.463, green: 0.463, blue: 0.463, alpha: 1)
  }

  private func setUITextFieldDelegate() {
    self.consumeView.consumedPriceTextField.delegate = self
    self.consumeView.consumedContentTextField.delegate = self
  }

  private func setButtonAction() {
    consumeView.categorySettingButton.addTarget(
      self, action: #selector(categorySettingButtonTapped), for: .touchUpInside)
    consumeView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
  }

  private func setDatePickerAction() {
    consumeView.consumedDatePicker.addTarget(
      self, action: #selector(dateChanged(_:)), for: .valueChanged)
  }

  /*
   observeSelectedCategory 함수의 설명
   - 하위 ViewController로 연결된 categorySelectTableViewController의 $selectedCategoryName값을
   감지해서 상위 ViewController인 consumeViewController의 categorySettingButton의 타이틀로 사용합니다.
   - 다른 클래스에 있는 프로퍼티값의 변화를 감지해서 해당 프로퍼티를 observe 중인 클래스에 영향을 미칩니다.
   */
  private func observeSelectedCategory() {
    self.categorySelectTableViewController.$selectedCategoryName
      .sink { [weak self] newValue in
        self?.consumeView.categorySettingButton.setTitle(newValue, for: .normal)
        self?.selectedCategory = newValue
      }
      .store(in: &cancellables)
  }
}

// MARK: - Object C Methods

extension ConsumeViewController {
  @objc
  private func dateChanged(_ sender: UIDatePicker) {
    self.selectedDate = sender.date

    /*
     해야 할 일
     - 서버로 보낼 날짜 데이터 형식으로 전환해야 함
     */
  }

  @objc
  private func rightBarButtonItemButtonTapped() {
    debugPrint("소비기록 버튼 탭")
    navigationController?.pushViewController(ConsumedHistoryTableViewController(), animated: true)
  }

  @objc
  private func categorySettingButtonTapped() {
    debugPrint("카테고리 세팅 버튼 탭")

    navigationController?.pushViewController(self.categorySelectTableViewController, animated: true)
  }

  @objc
  private func addButtonTapped() {
    debugPrint("추가하기 버튼 탭")
    /*
     해야 할 일
     - "추가하기 버튼"이 탭 되었을 때, 서버로 새로운 소비기록을 발송합니다.
     - 여기서 Variable 프로퍼티를 전부 서버로 발송합니다.
     */
    debugPrint(self.writtenConsumedPriceText)
    debugPrint(self.writtenConsumedContentText)
    debugPrint(self.selectedDate)
    debugPrint(self.selectedCategory)
  }
}

// MARK: - Network

extension ConsumeViewController {

}

// MARK: - UITextField Delegate

extension ConsumeViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    switch textField {
    case self.consumeView.consumedPriceTextField:
      if let text = textField.text {
        self.writtenConsumedPriceText = text
      }
    case self.consumeView.consumedContentTextField:
      if let text = textField.text {
        self.writtenConsumedContentText = text
      }
    default:
      debugPrint("알 수 없는 텍스트 필드에 접근했습니다")
    }
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
