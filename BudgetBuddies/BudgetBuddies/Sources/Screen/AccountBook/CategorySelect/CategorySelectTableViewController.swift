//
//  CategorySelectTableViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/22/24.
//

import SnapKit
import UIKit

class CategorySelectTableViewController: UITableViewController {
  // MARK: - Properties

  private let heightBetweenCells: CGFloat = 12
  private let heightOfCell: CGFloat = 72

  // 기본 카테고리는 수정이 되면 안됨
  private var defaultCategory = [
    DefaultCategory(
      iconImage: BudgetBuddiesAsset.AppImage.CategoryIcon.foodIcon2.image, titleText: "식비"),
    DefaultCategory(
      iconImage: BudgetBuddiesAsset.AppImage.CategoryIcon.shoppingIcon2.image, titleText: "쇼핑"),
    DefaultCategory(
      iconImage: BudgetBuddiesAsset.AppImage.CategoryIcon.fashionIcon2.image, titleText: "패션"),
    DefaultCategory(
      iconImage: BudgetBuddiesAsset.AppImage.CategoryIcon.cultureIcon2.image, titleText: "문화생활"),
    DefaultCategory(
      iconImage: BudgetBuddiesAsset.AppImage.CategoryIcon.trafficIcon2.image, titleText: "교통"),
    DefaultCategory(
      iconImage: BudgetBuddiesAsset.AppImage.CategoryIcon.cafeIcon2.image, titleText: "카페"),
    DefaultCategory(
      iconImage: BudgetBuddiesAsset.AppImage.CategoryIcon.playIcon2.image, titleText: "유흥"),
    DefaultCategory(
      iconImage: BudgetBuddiesAsset.AppImage.CategoryIcon.eventIcon2.image, titleText: "경조사"),
    DefaultCategory(
      iconImage: BudgetBuddiesAsset.AppImage.CategoryIcon.regularPaymentIcon2.image,
      titleText: "정기결제"),
    DefaultCategory(
      iconImage: BudgetBuddiesAsset.AppImage.CategoryIcon.etcIcon2.image, titleText: "기타"),
  ]

  // 기본 카테고리를 제거할 수 없도록 설정한 코드
  private var defaultCategoryIndex = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

  // 사용자 추가 카테고리는 서버에 반영되거나 앱 저장공간에 반영되어야 함
  // MARK: - View Life Cycle

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

  // MARK: - Table view data source & delegate

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return defaultCategory.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    let cell =
      tableView.dequeueReusableCell(
        withIdentifier: CategorySelectTableViewCell.identifier, for: indexPath)
      as! CategorySelectTableViewCell

    cell.categoryIcon.image = defaultCategory[indexPath.row].iconImage
    cell.categoryText.text = defaultCategory[indexPath.row].titleText

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
    debugPrint("선택한 셀 탭")

    navigationController?.popViewController(animated: true)
  }

  override func tableView(
    _ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    if editingStyle == .delete {
      defaultCategory.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }

  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return !defaultCategoryIndex.contains(indexPath.row)
  }

  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)
    -> UITableViewCell.EditingStyle
  {
    return defaultCategoryIndex.contains(indexPath.row) ? .none : .delete
  }

  override func tableView(
    _ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath
  ) -> String? {
    return "삭제"
  }
}
