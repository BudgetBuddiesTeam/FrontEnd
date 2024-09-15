//
//  ConsumedHistoryDetailViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/25/24.
//

import Combine
import Moya
import SnapKit
import UIKit

/*
 해야 할 일
 - 소비기록 제거 버튼 로직 설계
 - 지출일시 변경 로직
 - "저장하기" 버튼 로직 설계
 */

final class ConsumedHistoryDetailViewController: UIViewController {
  // MARK: - Properties

  // View Properties
  private let consumedHistoryDetailView = ConsumedHistoryDetailView()
  private let categorySelectTableViewController = CategorySelectTableViewController()

  // Combine Library Properties
  private var cancellables = Set<AnyCancellable>()

  // Network Variable
  private var provider = MoyaProvider<ExpenseRouter>()

  // Variable Properties
  private let userId = 1
  private var categoryId = 0
  private var categoryName = ""
  private var amount = 0
  private var expenseDescription = ""
  private var expenseDate = Date()

  private var expenseId: Int

  // MARK: - Intializer

  init(expenseId: Int) {
    self.expenseId = expenseId

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Life Cycle

  override func loadView() {
    view = consumedHistoryDetailView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.getSingleExpense(expenseId: self.expenseId)
    setNavigation()
    setButtonAction()
    setDatePickerAction()
    observeSelectedCategory()
  }

  // MARK: - Methods

  private func setNavigation() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "trash.fill"), style: .plain, target: self,
      action: #selector(trashRightBarButtonTapped))
    navigationController?.navigationBar.tintColor = BudgetBuddiesAppAsset.AppColor.subGray.color

    self.addBackButton(selector: #selector(didTapBarButton))
  }

  private func setButtonAction() {
    consumedHistoryDetailView.categorySettingButton.addTarget(
      self, action: #selector(categorySettingButtonTapped), for: .touchUpInside)
    consumedHistoryDetailView.saveButton.addTarget(
      self, action: #selector(saveButtonTapped), for: .touchUpInside)
  }

  private func setDatePickerAction() {
    consumedHistoryDetailView.consumedDatePicker.addTarget(
      self, action: #selector(dateChanged(_:)), for: .valueChanged)
  }

  private func observeSelectedCategory() {
    self.categorySelectTableViewController.$selectedCategoryName
      .sink { [weak self] newValue in
        self?.categoryName = newValue

        /*
         해야 할 일
         - 카테고리 이름에 따른 이미지 반환 함수 모듈화
         */

        let categoryImage: UIImage
        let categoryId: Int
        switch newValue {
        case "식비":
          categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.foodIcon2.image
        case "쇼핑":
          categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.shoppingIcon2.image
        case "패션":
          categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.fashionIcon2.image
        case "문화생활":
          categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.cultureIcon2.image
        case "교통":
          categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.trafficIcon2.image
        case "카페":
          categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.cafeIcon2.image
        case "유흥":
          categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.playIcon2.image
        case "경조사":
          categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.eventIcon2.image
        case "정기결제":
          categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.regularPaymentIcon2.image
        case "기타":
          categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.etcIcon2.image
        default:
          categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.personal2.image
        }
        self?.consumedHistoryDetailView.categoryIcon.image = categoryImage
        self?.consumedHistoryDetailView.categorySettingButton.setTitle(
          self?.categoryName, for: .normal)
      }
      .store(in: &cancellables)

    self.categorySelectTableViewController.$selectedCateogryId
      .sink { [weak self] newValue in
        self?.categoryId = newValue
      }
      .store(in: &cancellables)
  }
}

// MARK: - Network

extension ConsumedHistoryDetailViewController {

  /// 서버에서 단일 소비 내역 조회 메소드
  private func getSingleExpense(expenseId: Int) {
    provider.request(.getSingleExpense(userId: self.userId, expenseId: expenseId)) { result in
      switch result {
      case .success(let response):
        do {
          let decodedData = try JSONDecoder().decode(ExpenseResponseDTO.self, from: response.data)
          self.categoryId = decodedData.categoryId
          self.categoryName = decodedData.categoryName
          self.amount = decodedData.amount
          self.expenseDescription = decodedData.expenseDescription
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
          if let formattedDate = dateFormatter.date(from: decodedData.expenseDate) {
            self.expenseDate = formattedDate
          } else {

            /*
             해야 할 일
             - 옵셔널 데이터를 바인딩할 때, 처리 방법에 대한 연구
             */

            self.expenseDate = Date()
          }

          /*
           해야 할 일
           - 카테고리 아이디에 따른 이미지 반환 함수 모듈화
           */

          let categoryImage: UIImage
          switch self.categoryId {
          case 1:
            categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.foodIcon2.image
          case 2:
            categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.shoppingIcon2.image
          case 3:
            categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.fashionIcon2.image
          case 4:
            categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.cultureIcon2.image
          case 5:
            categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.trafficIcon2.image
          case 6:
            categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.cafeIcon2.image
          case 7:
            categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.playIcon2.image
          case 8:
            categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.eventIcon2.image
          case 9:
            categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.regularPaymentIcon2.image
          case 10:
            categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.etcIcon2.image
          default:
            categoryImage = BudgetBuddiesAppAsset.AppImage.CategoryIcon.personal2.image
          }

          self.consumedHistoryDetailView.categoryIcon.image = categoryImage
          self.consumedHistoryDetailView.categorySettingButton.setTitle(
            self.categoryName, for: .normal)
          self.consumedHistoryDetailView.priceLabel.updateExpensePriceDate(amount: self.amount)
          self.consumedHistoryDetailView.expenseDescriptionLabel.text = self.expenseDescription
          self.consumedHistoryDetailView.consumedDatePicker.date = self.expenseDate
        } catch {
          //
        }
      case .failure:
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

  /// 해당 단일 소비 내역 제거 후 서버로 변경사항 발송
  private func deleteExpense(expenseId: Int) {
    provider.request(.deleteSingleExpense(expenseId: self.expenseId)) { result in
      switch result {
      case .success:
        let deleteConfirmedAlertController = UIAlertController(
          title: "알림", message: "소비 내역 삭제 성공", preferredStyle: .alert)
        let confirmedButtonAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
          self?.navigationController?.popViewController(animated: true)
        }
        deleteConfirmedAlertController.addAction(confirmedButtonAction)
        self.present(deleteConfirmedAlertController, animated: true)
      case .failure:
        let deleteFailureAlertController = UIAlertController(
          title: "다시 시도하세요", message: "소비 내역 삭제 실패", preferredStyle: .alert)
        let confirmedButtonAction = UIAlertAction(title: "확인", style: .default)
        deleteFailureAlertController.addAction(confirmedButtonAction)
        self.present(deleteFailureAlertController, animated: true)
      }
    }
  }

  /// 단일 소비 내역 편집 후 서버 업로드 메소드
  private func postUpdatedSingleExpense(
    userId: Int, expenseUpdatedRequestDTO: ExpenseUpdateRequestDTO
  ) {
    provider.request(
      .postUpdatedSingleExpense(userId: userId, updatedExpenseRequestDTO: expenseUpdatedRequestDTO)
    ) { result in
      switch result {
      case .success(let response):
        do {
          let decodedData = try JSONDecoder().decode(ExpenseResponseDTO.self, from: response.data)
        } catch {
          let postUpdatedFailureUIAlertController = UIAlertController(
            title: "다시 시도하세요", message: "소비 내역 업데이트 실패", preferredStyle: .alert)
          let confirmedButtonAction = UIAlertAction(title: "확인", style: .default)
          postUpdatedFailureUIAlertController.addAction(confirmedButtonAction)

        }
        let postUpdatedConfirmedUIAlertController = UIAlertController(
          title: "알림", message: "업데이트 성공", preferredStyle: .alert)
        let confirmedButtonAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
          self?.navigationController?.popViewController(animated: true)
        }
        postUpdatedConfirmedUIAlertController.addAction(confirmedButtonAction)
        self.present(postUpdatedConfirmedUIAlertController, animated: true)
      case .failure:
        let postUpdatedFailureUIAlertController = UIAlertController(
          title: "다시 시도하세요", message: "소비 내역 업데이트 실패", preferredStyle: .alert)
        let confirmedButtonAction = UIAlertAction(title: "확인", style: .default)
        postUpdatedFailureUIAlertController.addAction(confirmedButtonAction)
        self.present(postUpdatedFailureUIAlertController, animated: true)
      }
    }
  }
}

// MARK: - Object C Methods

extension ConsumedHistoryDetailViewController {
  @objc
  private func didTapBarButton() {
    self.navigationController?.popViewController(animated: true)
  }

  @objc
  private func categorySettingButtonTapped() {
    navigationItem.backBarButtonItem = UIBarButtonItem()
    navigationController?.pushViewController(self.categorySelectTableViewController, animated: true)
  }

  @objc
  private func saveButtonTapped() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let formattedExpenseDate = dateFormatter.string(from: self.expenseDate)
    let expenseUpdatedRequestDTO = ExpenseUpdateRequestDTO(
      expenseId: self.expenseId, categoryId: self.categoryId, expenseDate: formattedExpenseDate,
      amount: self.amount)
    self.postUpdatedSingleExpense(
      userId: self.userId, expenseUpdatedRequestDTO: expenseUpdatedRequestDTO)
  }

  @objc
  private func trashRightBarButtonTapped() {
    self.deleteExpense(expenseId: self.expenseId)
  }

  @objc
  private func dateChanged(_ sender: UIDatePicker) {
    self.expenseDate = sender.date
  }
}
