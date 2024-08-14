//
//  CategorySelectTableViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/22/24.
//

import SnapKit
import UIKit
import Moya
import Combine

/*
 해야 할 일
 1. 기본 카테고리는 서버에서 isDefault 값으로 결정할 수 있음
 2. 카테고리 id에 따라서 카테고리 아이콘을 선정할 수 있는 enum을 설계
 */

class CategorySelectTableViewController: UITableViewController {
  // MARK: - Properties

  private let heightBetweenCells: CGFloat = 12
  private let heightOfCell: CGFloat = 72
  
  private let provider = MoyaProvider<CategoryRouter>()

  // 서버에서 가져온 카테고리 항목들을 저장하는 모델 배열
  private var categories: [CategoryResponseDTO] = []

  // 기본 카테고리를 제거할 수 없도록 설정한 코드
  private var defaultCategoryIndex = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  
  @Published var selectedCategoryName = "카테고리를 선택하세요"

  // MARK: - View Life Cycle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.fetchDataFromCategoryControllerAPI()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // 배경색이 완전 하얀색이 아님
    view.backgroundColor = UIColor(red: 0.978, green: 0.978, blue: 0.978, alpha: 1)

    // tableView의 회색 구분선 제거하기
    tableView.separatorStyle = .none
    tableView.register(
      CategorySelectTableViewCell.self,
      forCellReuseIdentifier: CategorySelectTableViewCell.identifier)
    setNavigation()
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
  }

  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    tableView.reloadData()
  }

  @objc
  private func editButtonTapped() {
    isEditing = true
    setEditing(isEditing, animated: true)

    navigationItem.title = "카테고리 편집"
    navigationItem.rightBarButtonItems = [
      UIBarButtonItem(
        image: UIImage(systemName: "checkmark.circle"), style: .plain, target: self,
        action: #selector(circleButtonTapped)),
      UIBarButtonItem(
        image: UIImage(systemName: "plus"), style: .plain, target: self,
        action: #selector(plusButtonTapped)),
    ]
  }

  @objc
  private func circleButtonTapped() {
    isEditing = false
    setEditing(false, animated: true)

    navigationItem.title = "카테고리 설정"
    navigationItem.rightBarButtonItems = .none
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "pencil"), style: .plain, target: self,
      action: #selector(editButtonTapped))
  }

  @objc
  private func plusButtonTapped() {
    self.present(CategoryPlusViewController(), animated: true)
  }
  
  // MARK: - Network
  
  /// 카테고리 컨트롤러 서버에서 데이터를 가져오는 함수입니다.
  private func fetchDataFromCategoryControllerAPI() {
    provider.request(.getCategoryWithPathVariable(userId: 1)) { [weak self] result in
      switch result {
      case .success(let response):
        debugPrint("카테고리 컨트롤러 API로부터 데이터 가져오기 성공")
        debugPrint(response.statusCode)
        do {
          let decodedData = try JSONDecoder().decode([CategoryResponseDTO].self, from: response.data)
          debugPrint("카테고리 컨트롤러 API로부터 추출한 데이터 디코딩 성공")
          self?.categories = decodedData
          self?.tableView.reloadData()
        } catch (let error) {
          debugPrint("카테고리 컨트롤러 API로부터 추출한 데이터 디코딩 실패")
          debugPrint(error.localizedDescription)
        }
      case .failure(let error):
        debugPrint("카테고리 컨트롤러 API로부터 데이터 가져오기 실패")
        debugPrint(error.localizedDescription)
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
      categories.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      
      // 제거된 카테고리를 서버에도 반영해야 합니다.
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
