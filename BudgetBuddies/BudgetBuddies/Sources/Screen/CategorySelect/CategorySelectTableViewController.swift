//
//  CategorySelectTableViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/22/24.
//

/*
 해야 할 일
 1. 셀 클릭하면 뒷 부분 색 변하는 버그 제거
 2. Navigation에서 뒤로가기 버튼의 타이틀 숨기기
 */

import SnapKit
import UIKit

class CategorySelectTableViewController: UITableViewController {
  // MARK: - Properties
  let heightBetweenCells: CGFloat = 12
  let heightOfCell: CGFloat = 72
  var categoryType = [
    "식비",
    "패션",
    "문화생활",
    "교통",
    "카페",
    "유흥",
    "경조사",
    "정기결제",
    "기타",
  ]

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
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "pencil"), style: .plain, target: self, action: nil)

    navigationController?.navigationBar.tintColor = UIColor(
      red: 0.463, green: 0.463, blue: 0.463, alpha: 1)
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categoryType.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    let cell =
      tableView.dequeueReusableCell(
        withIdentifier: CategorySelectTableViewCell.identifier, for: indexPath)
      as! CategorySelectTableViewCell
    cell.categoryText.text = categoryType[indexPath.row]
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
  
  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return heightBetweenCells
  }

  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
  {
    let headerView = UIView()
    headerView.backgroundColor = .clear
    return headerView
  }
  
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UIView()
    footerView.backgroundColor = .clear
    return footerView
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    debugPrint("선택한 셀 탭")
  }
}
