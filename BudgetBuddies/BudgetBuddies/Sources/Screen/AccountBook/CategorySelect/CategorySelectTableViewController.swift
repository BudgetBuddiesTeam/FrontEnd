//
//  CategorySelectTableViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/22/24.
//

import Combine
import Moya
import SnapKit
import UIKit

/*
 해야 할 일
 1. 기본 카테고리는 서버에서 isDefault 값으로 결정할 수 있음
 2. 카테고리 id에 따라서 카테고리 아이콘을 선정할 수 있는 enum을 설계
 */

class CategorySelectTableViewController: UITableViewController {
  // MARK: - Properties
  // 네비 애니메이션 변수
  var previousScrollOffset: CGFloat = 0.0
  var scrollThreshold: CGFloat = 1.0  // 네비게이션 바가 나타나거나

  // UITableView Delegate Properties
  private let heightBetweenCells: CGFloat = 12
  private let heightOfCell: CGFloat = 72

  // Network Properties
  private let provider = MoyaProvider<CategoryRouter>()

  // Variable Properties
  private let userId = 1
  // 서버에서 가져온 카테고리 항목들을 저장하는 모델 배열
  private var categories: [CategoryResponseDTO] = []
  // 기본 카테고리를 제거할 수 없도록 설정한 코드
  private var defaultCategoryIndex = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  @Published var selectedCategoryName = "카테고리를 선택하세요"
  @Published var selectedCateogryId = 0

  // MARK: - View Life Cycle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.setNavigation()
    self.getCategoriesFromServer()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // 배경색이 완전 하얀색이 아님
    view.backgroundColor = BudgetBuddiesAsset.AppColor.background.color

    // tableView의 회색 구분선 제거하기
    tableView.showsVerticalScrollIndicator = false
    tableView.showsHorizontalScrollIndicator = false
    tableView.separatorStyle = .none
    tableView.register(
      CategorySelectTableViewCell.self,
      forCellReuseIdentifier: CategorySelectTableViewCell.identifier)
    setNavigation()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    self.setEditing(false, animated: true)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.tableView.contentInset.bottom = 15
  }

  // MARK: - Methods

  private func setNavigation() {
    navigationItem.title = "카테고리 설정"

    // 커스텀 수정 버튼
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "pencil"), style: .plain, target: self,
      action: #selector(editButtonTapped))

    navigationController?.navigationBar.tintColor = UIColor(
      red: 0.463, green: 0.463, blue: 0.463, alpha: 1)

    self.setupDefaultNavigationBar(backgroundColor: BudgetBuddiesAsset.AppColor.background.color)
    self.addBackButton(selector: #selector(didTapBarButton))
  }

  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)

    if editing {
      navigationItem.title = "카테고리 편집"
      navigationItem.rightBarButtonItems = [
        UIBarButtonItem(
          image: UIImage(systemName: "checkmark.circle"), style: .plain, target: self,
          action: #selector(circleButtonTapped)),
        UIBarButtonItem(
          image: UIImage(systemName: "plus"), style: .plain, target: self,
          action: #selector(plusButtonTapped)),
      ]
    } else {
      navigationItem.title = "카테고리 설정"
      navigationItem.rightBarButtonItems = .none
      navigationItem.rightBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "pencil"), style: .plain, target: self,
        action: #selector(editButtonTapped))
    }

    tableView.reloadData()
  }

  private func generateUIAlertControllerWithPopingViewController(message: String) {
    let alertController = UIAlertController(
      title: "알림", message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
      self?.navigationController?.popViewController(animated: true)
    }
    alertController.addAction(alertAction)
    self.present(alertController, animated: true)
  }

  private func generateUIAlertController(message: String) {
    let alertController = UIAlertController(
      title: "알림", message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
      self?.navigationController?.popViewController(animated: true)
    }
    alertController.addAction(alertAction)
    self.present(alertController, animated: true)
  }

  // MARK: - Object C Methods
  @objc
  private func didTapBarButton() {
    self.navigationController?.popViewController(
      animated: true
    )
  }

  @objc
  private func editButtonTapped() {
    self.setEditing(true, animated: true)
  }

  @objc
  private func circleButtonTapped() {
    setEditing(false, animated: true)
  }

  @objc
  private func plusButtonTapped() {
    let categoryPlusViewController = CategoryPlusViewController()
    categoryPlusViewController.dismissHandler = {
      self.tableView.reloadData()
    }
    self.present(categoryPlusViewController, animated: true)
  }

  // MARK: - Network

  /// 카테고리 컨트롤러 서버에서 데이터를 가져오는 함수입니다.
  private func getCategoriesFromServer() {
    provider.request(.getCategories(userId: self.userId)) { [weak self] result in
      switch result {
      case .success(let response):
        do {
          let decodedData = try JSONDecoder().decode(
            [CategoryResponseDTO].self, from: response.data)
          self?.categories = decodedData
          self?.tableView.reloadData()
        } catch {
          self?.generateUIAlertController(message: "카테고리를 불러오지 못했습니다")
        }
      case .failure:
        self?.generateUIAlertController(message: "서버와 연결을 실패했습니다")
      }
    }
  }

  /// 카테고리를 제거하는 메소드입니다.
  private func deleteCategory(categoryId: Int) {
    provider.request(.deleteCategory(userId: self.userId, categoryId: categoryId)) {
      [weak self] result in
      switch result {
      case .success:
        self?.generateUIAlertController(message: "카테고리 제거에 성공했습니다")
      case .failure:
        self?.generateUIAlertController(message: "카테고리 제거에 실패했습니다")
      }
    }
  }

  // MARK: - Table view data source & delegate

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    let cell =
      tableView.dequeueReusableCell(
        withIdentifier: CategorySelectTableViewCell.identifier, for: indexPath)
      as! CategorySelectTableViewCell

    let selectedCategory = self.categories[indexPath.row]

    cell.configure(categoryID: selectedCategory.id, categoryName: selectedCategory.name)

    //      cell.selectionStyle = .none
    return cell
  }

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    return heightOfCell + heightBetweenCells
  }

  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int)
    -> CGFloat
  {
    return heightBetweenCells
  }

  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int)
    -> CGFloat
  {
    return heightBetweenCells
  }

  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
  {
    let headerView = UIView()
    headerView.backgroundColor = .clear
    return headerView
  }

  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
  {
    let footerView = UIView()
    footerView.backgroundColor = .clear
    return footerView
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.selectedCategoryName = self.categories[indexPath.row].name
    self.selectedCateogryId = self.categories[indexPath.row].id

    navigationController?.popViewController(animated: true)
  }

  // 편집모드에서 제거버튼을 눌렀을 때, "삭제"라는 확인 버튼
  override func tableView(
    _ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath
  ) -> String? {
    return "삭제"
  }

  // 편집모드에서 제거버튼을 눌렀을 때, 해당 카테고리 항목이 제거되는 로직 함수
  override func tableView(
    _ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    if editingStyle == .delete {
      let categoryId = self.categories[indexPath.row].id
      self.deleteCategory(categoryId: categoryId)

      categories.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }

  // 기본 카테고리는 제거되지 않도록 설정하는 함수
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return !defaultCategoryIndex.contains(indexPath.row)
  }

  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)
    -> UITableViewCell.EditingStyle
  {
    return defaultCategoryIndex.contains(indexPath.row) ? .none : .delete
  }
}

extension CategorySelectTableViewController {
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let currentOffset = scrollView.contentOffset.y
    let offsetDifference = currentOffset - previousScrollOffset

    if currentOffset <= 0 {  // 스크롤을 완전히 위로 올렸을 때 네비게이션 바 나타냄
      navigationController?.setNavigationBarHidden(false, animated: true)

    } else if offsetDifference > scrollThreshold {  // 스크롤이 아래로 일정 이상 이동한 경우 네비게이션 바 숨김
      navigationController?.setNavigationBarHidden(true, animated: true)

    } else if offsetDifference < -scrollThreshold {  // 스크롤이 위로 일정 이상 이동한 경우 네비게이션 바 나타냄
      navigationController?.setNavigationBarHidden(false, animated: true)

    }

    previousScrollOffset = currentOffset
  }
}
