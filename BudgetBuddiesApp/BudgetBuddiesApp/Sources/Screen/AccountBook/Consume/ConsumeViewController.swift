//
//  ConsumeViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/22/24.
//

import Combine
import Foundation
import Moya
import SnapKit
import UIKit

final class ConsumeViewController: UIViewController {
  // MARK: - Properties

  // View
  private var consumeView = ConsumeView()

  // ViewController
  private lazy var categorySelectTableViewController = CategorySelectTableViewController()
  private lazy var consumedHistoryTableViewController = ConsumedHistoryTableViewController()

  // Network
  private let provider = MoyaProvider<ExpenseRouter>()

  // Combine
  private var cancellables = Set<AnyCancellable>()

  // Variable
  private let userId = 1
  private var writtenConsumedPriceText = ""
  private var writtenConsumedContentText = ""
  private var selectedDate = Date()
  private var selectedCategory = ""
  private var selectedCategoryId = 0

  // MARK: - View Life Cycle

  override func loadView() {
    view = consumeView
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavigation()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setNavigation()
    setUITextFieldDelegate()
    setButtonAction()
    setDatePickerAction()
    observeSelectedCategory()
  }

  // 키보드 내림
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }

  // MARK: - Methods

  private func setNavigation() {
    navigationItem.title = "소비 추가하기"

    // 뒤로가기 제스처 추가
    self.navigationController?.interactivePopGestureRecognizer?.delegate = self

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "소비기록", image: UIImage(systemName: "list.clipboard.fill"), target: self,
      action: #selector(rightBarButtonItemButtonTapped))

    navigationItem.backBarButtonItem = UIBarButtonItem()

    /*
     해야 할 일
     1. rightBarButtonItem의 색상을 Asset에 등록하고 사용하도록 설계
     */

    self.navigationController?.setNavigationBarHidden(false, animated: true)
    navigationItem.rightBarButtonItem?.tintColor = UIColor(
      red: 0.463, green: 0.463, blue: 0.463, alpha: 1)

    self.setupDefaultNavigationBar(backgroundColor: BudgetBuddiesAppAsset.AppColor.white.color)
    // 이전 뷰컨이 있으면 백 버튼 표시
    if self.hasPreviousViewController() {
      self.addBackButton(selector: #selector(didTapBarButton))
    }

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
      .sink { [weak self] newCategoryName in
        self?.consumeView.categorySettingButton.setTitle(newCategoryName, for: .normal)
        self?.selectedCategory = newCategoryName
      }
      .store(in: &cancellables)

    self.categorySelectTableViewController.$selectedCateogryId
      .sink { [weak self] newCategoryId in
        self?.selectedCategoryId = newCategoryId
      }
      .store(in: &cancellables)
  }
}

// MARK: - Object C Methods

extension ConsumeViewController {
  @objc
  private func didTapBarButton() {
    self.navigationController?.popViewController(animated: true)
  }

  @objc
  private func dateChanged(_ sender: UIDatePicker) {
    self.selectedDate = sender.date

    /*
     해야 할 일
     - 문자열 데이터 타입으로 보관하는 코드 작성
     */
  }

  @objc
  private func rightBarButtonItemButtonTapped() {
    navigationController?.pushViewController(
      self.consumedHistoryTableViewController, animated: true)
  }

  @objc
  private func categorySettingButtonTapped() {
    navigationController?.pushViewController(self.categorySelectTableViewController, animated: true)
  }

  @objc
  private func addButtonTapped() {
    /*
     해야 할 일
     - ViewController에 있는 비즈니스 로직 코드도 XCTest 프레임워크 기반으로 개발할 수 있는지 연구
     */
    let categoryId = self.selectedCategoryId
    let amount = Int(self.writtenConsumedPriceText) ?? 0
    let description = self.writtenConsumedContentText
    let expenseDate: String

    /*
     해야 할 일
     - 모델 객체에서 날짜를 저장하는 형식을 문자열로 보관
     - 문자열 형식 전환 처리는 날짜를 선택한 object c 메소드에 작성할 것
     */

    let dateFormatter = DateFormatter()
    /*
     해야 할 일
     - 서버에 발송하는 날짜 형식도 지정 날짜 형식으로 Namespace에 모듈화
     */
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

    expenseDate = dateFormatter.string(from: self.selectedDate)

    let newExpenseRequestDTO = NewExpenseRequestDTO(
      categoryId: categoryId,
      amount: amount,
      description: description,
      expenseDate: expenseDate
    )

    self.postNewExpense(newExpenseRequestDTO: newExpenseRequestDTO)
  }
}

// MARK: - Network

/*
 해야 할 일
 - 모델 객체로 분리
 */

extension ConsumeViewController {
  private func postNewExpense(newExpenseRequestDTO: NewExpenseRequestDTO) {
    provider.request(
      .postAddedExpense(userId: self.userId, addedExpenseRequestDTO: newExpenseRequestDTO)
    ) {
      result in
      switch result {
      case .success:
        let postSuccessAlertController = UIAlertController(
          title: "알림", message: "새로운 소비 내역을 추가했습니다", preferredStyle: .alert)
        let confirmedButtonAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
          self?.consumeView.consumedPriceTextField.text = String()
          self?.consumeView.consumedContentTextField.text = String()
          self?.consumeView.consumedDatePicker.date = Date()

          /*
           설명
           - 카테고리 선택 버튼은 CategorySelectTableViewController의 모델 객체의 데이터를 추종하는 성격이 있습니다.
           - 그래서 데이터를 직접 변경하면, ConsumeView의 addButton UI도 변경됩니다.
           */
          self?.categorySelectTableViewController.selectedCategoryName = "카테고리를 선택하세요"
          self?.categorySelectTableViewController.selectedCateogryId = 0
        }
        postSuccessAlertController.addAction(confirmedButtonAction)
        self.present(postSuccessAlertController, animated: true)
      case .failure:
        /*
         해야 할 일
         - UIAlertController 모듈화하기
         */
        let postFailureAlertController = UIAlertController(
          title: "문제발생", message: "새로운 소비 내역을 추가하지 못했습니다", preferredStyle: .alert)
        let confirmedButtonAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
          self?.navigationController?.popViewController(animated: true)
        }
        postFailureAlertController.addAction(confirmedButtonAction)
        self.present(postFailureAlertController, animated: true)
      }
    }
  }
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

// MARK: - 뒤로 가기 슬라이드 제스처 추가
extension ConsumeViewController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
