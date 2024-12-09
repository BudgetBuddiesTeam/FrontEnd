//
//  NoticeViewController.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 11/19/24.
//

import UIKit

class NoticeViewController: UIViewController {

  private lazy var noticeView = {
    let noticeView = NoticeView()
    noticeView.tableView.dataSource = self
    noticeView.tableView.delegate = self
    return noticeView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view = noticeView
    view.backgroundColor = .white
    setNavi()
  }

  private func setNavi() {
    navigationItem.title = "공지사항"

    // 뒤로가기 제스처 추가
    self.navigationController?.interactivePopGestureRecognizer?.delegate = self

    navigationController?.navigationBar.tintColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    self.setupDefaultNavigationBar(backgroundColor: BudgetBuddiesAppAsset.AppColor.white.color)
    self.addBackButton(selector: #selector(didTapBarButton))
  }

  @objc
  private func didTapBarButton() {
    self.navigationController?.popViewController(animated: true)
  }
}

extension NoticeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 83
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "NoticeTableViewCell", for: indexPath) as? NoticeTableViewCell
    else {
      return UITableViewCell()
    }
    cell.selectionStyle = .none
    cell.configure(title: "공지사항", content: "개인정보 처리방침 변경예정", date: "11월 25일")
    return cell
  }
}

// MARK: - 뒤로 가기 슬라이드 제스처 추가
extension NoticeViewController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
