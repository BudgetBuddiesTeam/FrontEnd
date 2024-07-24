//
//  CalendarViewController.swift
//  BudgetBuddiesLocal
//
//  Created by 김승원 on 7/15/24.
//

import SnapKit
import UIKit

final class CalendarViewController: UIViewController {
  var isCalendarExpanded: Bool = false

  var selectedMonth: Int? = 7 {
    didSet {
      guard let month = selectedMonth else { return }
      print("\(month)월로 바뀜")
      self.tableView.reloadData()
    }
  }

  // MARK: - Properties
  private lazy var tableView = UITableView()

  // MARK: - Life Cycle ⭐️
  override func viewWillAppear(_ animated: Bool) {

    setupNavigationBar()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = #colorLiteral(
      red: 0.97647053, green: 0.97647053, blue: 0.97647053, alpha: 1)

    setupNavigationBar()
    setupTableView()
  }

  // MARK: - Set up NavigationBar {
  private func setupNavigationBar() {
    navigationController?.navigationBar.isHidden = true
  }

  // MARK: - Set up TableView
  private func setupTableView() {
    print(#function)
    tableView.backgroundColor = .clear
    tableView.separatorStyle = .none
    tableView.allowsSelection = true
    tableView.showsVerticalScrollIndicator = false

    tableView.dataSource = self
    tableView.delegate = self

    // 셀 등록
    tableView.register(CalendarImageCell.self, forCellReuseIdentifier: "CalendarImageCell")
    tableView.register(MainCalendarCell.self, forCellReuseIdentifier: "MainCalendarCell")
    tableView.register(InfoTitleCell.self, forCellReuseIdentifier: "InfoTitleCell")
    tableView.register(InformationCell.self, forCellReuseIdentifier: "InfomationCell")

    self.view.addSubview(tableView)
    setupTableViewConstraints()
  }

  private func setupTableViewConstraints() {
    tableView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.trailing.equalToSuperview()
    }
  }
}

// MARK: - TableView DataSource
extension CalendarViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 8
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {  // 상단 이미지 셀
      let calendarImageCell =
        tableView.dequeueReusableCell(withIdentifier: "CalendarImageCell", for: indexPath)
        as! CalendarImageCell
      return calendarImageCell

    } else if indexPath.row == 1 {  // 메인 캘린더 셀
      let mainCalendarCell =
        tableView.dequeueReusableCell(withIdentifier: "MainCalendarCell", for: indexPath)
        as! MainCalendarCell
      mainCalendarCell.delegate = self

      if let month = selectedMonth {
        mainCalendarCell.month = month
        print("셀에 \(month)달 전달")
      }

      return mainCalendarCell

    } else if indexPath.row == 2 {  // 할인정보 타이틀 셀
      let infoTitleCell =
        tableView.dequeueReusableCell(withIdentifier: "InfoTitleCell", for: indexPath)
        as! InfoTitleCell
      let infoType: InfoTitleCell.InfoType = .discount
      infoTitleCell.configure(infoType: infoType)

      infoTitleCell.delegate = self

      return infoTitleCell

    } else if indexPath.row <= 4 {  // 할인정보 셀
      let informationCell =
        tableView.dequeueReusableCell(withIdentifier: "InfomationCell", for: indexPath)
        as! InformationCell
      let infoType: InformationCell.InfoType = .discount
      informationCell.configure(infoType: infoType)

      informationCell.infoTitleLabel.text = "지그재그 썸머세일"
      informationCell.dateLabel.text = "08.17 ~ 08.20"
      informationCell.percentLabel.text = "~80%"
      informationCell.urlString = "https://www.naver.com"

      informationCell.delegate = self

      return informationCell

    } else if indexPath.row == 5 {  // 지원정보 타이틀 셀
      let infoTitleCell =
        tableView.dequeueReusableCell(withIdentifier: "InfoTitleCell", for: indexPath)
        as! InfoTitleCell
      let infoType: InfoTitleCell.InfoType = .support
      infoTitleCell.configure(infoType: infoType)

      infoTitleCell.delegate = self

      return infoTitleCell

    } else if indexPath.row <= 7 {  // 지원정보 셀
      let informationCell =
        tableView.dequeueReusableCell(withIdentifier: "InfomationCell", for: indexPath)
        as! InformationCell
      let infoType: InformationCell.InfoType = .support
      informationCell.configure(infoType: infoType)

      informationCell.infoTitleLabel.text = "국가장학금 1차 신청"
      informationCell.dateLabel.text = "08.17 ~ 08.20"
      informationCell.urlString = "https://www.google.com"

      informationCell.delegate = self

      return informationCell
    }

    return UITableViewCell()
  }
}

// MARK: - TableView Delegate
extension CalendarViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {  // 상단 이미지 셀
      return CGFloat(127)  // 64 + 34 + 11 + 17 + 1(올림)

    } else if indexPath.row == 1 {  // 메인 켈린더 셀
      //            return CGFloat(532 + 6) // 510 + 7 + 15 + 6
      return isCalendarExpanded ? CGFloat(600) : CGFloat(532 + 6)

    } else if indexPath.row == 2 {  // 할인정보 타이틀 셀
      return CGFloat(64)  // 28 - 6 + 36 + 6

    } else if indexPath.row <= 4 {  // 할인정보 셀
      return CGFloat(168)  // 156 + 6 + 6

    } else if indexPath.row == 5 {  // 지원정보 타이틀 셀
      return CGFloat(64)

    } else if indexPath.row <= 7 {  // 지원정보 셀
      return CGFloat(168)
    }

    return CGFloat(0)
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let index = indexPath.row
    if index == 3 || index == 4 || index == 6 || index == 7 {
      print("\(indexPath.row)셀 클릭")
    }
  }
}

// MARK: - InfomationCell Delegate
extension CalendarViewController: InformationCellDelegate {
  func didTapWebButton(in cell: InformationCell, urlString: String) {
    print("커스텀 델리게이트, 뷰컨에서 받음")

    let vc = WebViewController(with: urlString)
    let nav = UINavigationController(rootViewController: vc)
    nav.modalPresentationStyle = .fullScreen
    self.present(nav, animated: true, completion: nil)
  }
}

// MARK: - InfoTitleCell Delegate
extension CalendarViewController: InfoTitleCellDelegate {
  func didTapShowDetailViewButton(in cell: InfoTitleCell, infoType: InfoTitleCell.InfoType) {
    print("커스텀 델리게이트")

    switch infoType {
    case .discount:
      let vc = DetailViewController(infoType: .discount)
      vc.title = "8월 할인정보"  // 달력 받기
      self.navigationController?.pushViewController(vc, animated: true)

    case .support:
      let vc = DetailViewController(infoType: .support)
      vc.title = "8월 지원정보"  // 달력 받기
      self.navigationController?.pushViewController(vc, animated: true)

    }
  }
}

// MARK: - MainCalendarCell Delegate
extension CalendarViewController: MainCalendarCellDelegate {
  func didEncounterSixWeekMonth(in cell: MainCalendarCell) {
    print("커스텀 델리게이트: 6줄 이상 출력됨")
    self.isCalendarExpanded = true
  }

  func didTapSelectMonthButton(in cell: MainCalendarCell) {
    print("캘린더셀 커스텀 델리게이트 전달")
    let vc = MonthPickerViewController()
    vc.currentSelectedMonth = selectedMonth
    vc.delegate = self
    self.present(vc, animated: true, completion: nil)
  }
}

// MARK: - MonthPickerView Delegate
extension CalendarViewController: MonthPickerViewDelegate {
  func didViewClosed(selectedMonth: Int) {
    print("커스텀 델리게이트 전달 완료: \(selectedMonth)월 선택")
    self.selectedMonth = selectedMonth
  }
}
