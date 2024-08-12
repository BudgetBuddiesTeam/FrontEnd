//
//  CalendarViewController.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/24/24.
//

import SnapKit
import UIKit

final class CalendarViewController: UIViewController {
  // MARK: - Properties
  enum CalendarCellType {
    case banner
    case calendar
    case discountInfoTitleWithButton
    case firstDiscount
    case secondDiscount
    case supportInfoTitleWithButton
    case firstSupport
    case secondSupport
  }

  var cellTypes: [CalendarCellType] = []

  var yearMonth: YearMonth? {
    didSet {
      setupData()
    }
  }

  // networking
  var calendarManager = CalendarManager.shared

  // 추천 정보들 (2개씩 나오는 거)
  var discountRecommends: [TInfoDtoList] = []
  var supportRecommends: [TInfoDtoList] = []

  // MARK: - UI Components
  lazy var tableView = UITableView()

  // MARK: - Life Cycle ⭐️
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = BudgetBuddiesAsset.AppColor.background.color

    setupNowYearMonth()
    setupData()
    setupNavigationBar()
    setupTableView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    setupNavigationBar()
  }
  // MARK: - Set up Now YearMonth
  private func setupNowYearMonth() {
    let currentDate = Date()
    let calendar = Calendar.current

    let currentYear = calendar.component(.year, from: currentDate)
    let currentMonth = calendar.component(.month, from: currentDate)

    // 현재 시간
    self.yearMonth = YearMonth(year: currentYear, month: currentMonth)

  }

  // MARK: - Set up Data
  private func setupData() {

    // networking
    guard let yearMonth = self.yearMonth else { return }
    calendarManager.fetchCalendar(request: yearMonth) { result in
      print("------------캘린더정보 불러오기-------------")
      switch result {
      case .success(let response):
        print("데이터 디코딩 성공")
        //              self.recommends = response.recommendMonthInfoDto
        self.discountRecommends = response.recommendMonthInfoDto.discountInfoDtoList
        self.supportRecommends = response.recommendMonthInfoDto.supportInfoDtoList

        DispatchQueue.main.async {
          self.tableView.reloadData()
        }

      case .failure(let error):
        print("데이터 디코딩 실패")
        print(error.localizedDescription)
      }
    }
  }

  // MARK: - Set up NavigationBar
  private func setupNavigationBar() {
    navigationController?.navigationBar.isHidden = true
  }

  // MARK: - Set up TableView
  private func setupTableView() {
    self.cellTypes = [
      .banner,
      .calendar,
      .discountInfoTitleWithButton,
      .firstDiscount,
      .secondDiscount,
      .supportInfoTitleWithButton,
      .firstSupport,
      .secondSupport,
    ]

    registerTableViewCell()

    tableView.backgroundColor = .clear
    tableView.separatorStyle = .none
    tableView.allowsSelection = true
    tableView.showsVerticalScrollIndicator = false

    tableView.dataSource = self
    tableView.delegate = self

    self.view.addSubview(tableView)

    // 제약조건
    tableView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.trailing.equalToSuperview()
    }
  }

  // MARK: - Register TableView Cell
  private func registerTableViewCell() {
    tableView.register(BannerCell.self, forCellReuseIdentifier: BannerCell.identifier)
    tableView.register(MainCalendarCell.self, forCellReuseIdentifier: MainCalendarCell.identifier)
    tableView.register(
      InfoTitleWithButtonCell.self, forCellReuseIdentifier: InfoTitleWithButtonCell.identifier)
    tableView.register(InformationCell.self, forCellReuseIdentifier: InformationCell.identifier)
  }
}

// MARK: - UITableView DataSource
extension CalendarViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellTypes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cellType = cellTypes[indexPath.row]

    switch cellType {
    // MARK: - 상단 배너
    case .banner:
      let bannerCell =
        tableView.dequeueReusableCell(withIdentifier: BannerCell.identifier, for: indexPath)
        as! BannerCell

      bannerCell.selectionStyle = .none
      return bannerCell

    // MARK: - 메인 캘린더
    case .calendar:
      let mainCalendarCell =
        tableView.dequeueReusableCell(withIdentifier: MainCalendarCell.identifier, for: indexPath)
        as! MainCalendarCell

      // 임시로 날짜 전달
      if let calendarModel = yearMonth {
        mainCalendarCell.yearMonth = calendarModel
        mainCalendarCell.isSixWeek = calendarModel.isSixWeeksLong()
        // 여기서 나중에 특정월에있는 할인지원정보들 fetch해서 보내기
      }

      mainCalendarCell.delegate = self

      mainCalendarCell.selectionStyle = .none
      return mainCalendarCell

    // MARK: - 할인정보 타이틀
    case .discountInfoTitleWithButton:
      let infoTitleWithButtonCell =
        tableView.dequeueReusableCell(
          withIdentifier: InfoTitleWithButtonCell.identifier, for: indexPath)
        as! InfoTitleWithButtonCell
      infoTitleWithButtonCell.configure(infoType: .discount)

      // 대리자 설정
      infoTitleWithButtonCell.delegate = self

      infoTitleWithButtonCell.selectionStyle = .none
      return infoTitleWithButtonCell

    // MARK: - 할인정보 1
    case .firstDiscount:
      let informationCell =
        tableView.dequeueReusableCell(withIdentifier: InformationCell.identifier, for: indexPath)
        as! InformationCell
      informationCell.configure(infoType: .discount)

      // 대리자 설정
      informationCell.delegate = self

      // 데이터 전달
      if discountRecommends.indices.contains(0) {
        informationCell.recommend = discountRecommends[0]

      } else {
        print("할인정보 1: Index 0 is out of range.")

      }

      informationCell.selectionStyle = .none
      return informationCell

    // MARK: - 할인정보 2
    case .secondDiscount:
      let informationCell =
        tableView.dequeueReusableCell(withIdentifier: InformationCell.identifier, for: indexPath)
        as! InformationCell
      informationCell.configure(infoType: .discount)

      // 대리자 설정
      informationCell.delegate = self

      // 데이터 전달
      if discountRecommends.indices.contains(1) {
        informationCell.recommend = discountRecommends[1]
      } else {
        print("할인정보 2: Index 1 is out of range.")
      }

      informationCell.selectionStyle = .none
      return informationCell

    // MARK: - 지원정보 타이틀
    case .supportInfoTitleWithButton:
      let infoTitleWithButtonCell =
        tableView.dequeueReusableCell(
          withIdentifier: InfoTitleWithButtonCell.identifier, for: indexPath)
        as! InfoTitleWithButtonCell
      infoTitleWithButtonCell.configure(infoType: .support)

      // 대리자 설정
      infoTitleWithButtonCell.delegate = self

      infoTitleWithButtonCell.selectionStyle = .none
      return infoTitleWithButtonCell

    // MARK: - 지원정보 1
    case .firstSupport:
      let informationCell =
        tableView.dequeueReusableCell(withIdentifier: InformationCell.identifier, for: indexPath)
        as! InformationCell
      informationCell.configure(infoType: .support)

      // 대리자 설정
      informationCell.delegate = self

      // 데이터 전달
      if discountRecommends.indices.contains(0) {
        informationCell.recommend = supportRecommends[0]
      } else {
        print("지원정보 1: Index 0 is out of range.")
      }

      informationCell.selectionStyle = .none
      return informationCell

    // MARK: - 지원정보 2
    case .secondSupport:
      let informationCell =
        tableView.dequeueReusableCell(withIdentifier: InformationCell.identifier, for: indexPath)
        as! InformationCell
      informationCell.configure(infoType: .support)

      // 대리자 설정
      informationCell.delegate = self

      // 데이터 전달
      if discountRecommends.indices.contains(1) {
        informationCell.recommend = supportRecommends[1]
      } else {
        print("지원정보 2: Index 1 is out of range.")
      }

      informationCell.selectionStyle = .none
      return informationCell
    }
  }
}

// MARK: - UITableView Delegate
extension CalendarViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {  // 상단 배너
      return 127  //

    } else if indexPath.row == 1 {  // 메인 캘린더
      //      return 538 // 510 + 7 + 15 + 6
      return UITableView.automaticDimension

    } else if indexPath.row == 2 {  // 할인정보 타이틀, 전체보기 버튼
      return 64

    } else if indexPath.row == 3 || indexPath.row == 4 {  // 할인정보 셀
      return 168

    } else if indexPath.row == 5 {  // 지원정보 타이틀, 전체보기 버튼
      return 64

    } else if indexPath.row == 6 || indexPath.row == 7 {  // 지원정보 셀
      return 168
    }

    return 100
  }

  //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
  //        if indexPath.row == 1 {
  //            return 538 // 캘린더 셀 최소 높이
  //        }
  //
  //        return UITableView.automaticDimension
  //    }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if indexPath.row == 0 {
          print("CalendarViewController2 연결")
          let vc = CalendarViewController2()
          vc.modalPresentationStyle = .fullScreen
          self.present(vc, animated: true, completion: nil)
      }
      
    if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 6 || indexPath.row == 7 {
      let vc = BottomSheetViewController()
      vc.modalPresentationStyle = .overFullScreen
      self.present(vc, animated: true, completion: nil)
    }
  }
}

// MARK: - MonthPickerViewController Delegate
extension CalendarViewController: MonthPickerViewControllerDelegate {
  // 년도, 달 바꾸기 완료 버튼을 누르는 시점
  func didTapSelectButton(year: Int, month: Int) {
    print("CalendarViewController 전달받은 날짜: \(year)년 \(month)월")
    self.yearMonth = YearMonth(year: year, month: month)
  }
}

// MARK: - MainCalendarCell Delegate
extension CalendarViewController: MainCalendarCellDelegate {
  // 년도, 달 바꾸기 버튼 누르는 시점
  func didTapSelectYearMonth(in cell: MainCalendarCell) {
    let vc = MonthPickerViewController()
    vc.yearMonth = yearMonth

    vc.delegate = self

    self.present(vc, animated: true, completion: nil)
  }
}

// MARK: - InfoTitleWithButtonCell Delegate
extension CalendarViewController: InfoTitleWithButtonCellDelegate {
  // infoTitleWithButtonCell: 전체보기 버튼 눌리는 시점
  func didTapShowDetailViewButton(
    in cell: InfoTitleWithButtonCell, infoType: InfoType
  ) {

    guard let yearMonth = self.yearMonth else { return }
    guard let month = yearMonth.month else { return }

    let vc: InfoListViewController

    switch infoType {
    case .discount:
      vc = InfoListViewController(infoType: .discount)
      vc.title = "\(month)월 할인정보"  // 추후에 데이터 받기

    case .support:
      vc = InfoListViewController(infoType: .support)
      vc.title = "\(month)월 지원정보"  // 추후에 데이터 받기
    }

    vc.yearMonth = self.yearMonth
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

// MARK: - InformationCell Delegate
extension CalendarViewController: InformationCellDelegate {
  // informationCell: 사이트 바로가기 버튼이 눌리는 시점
  func didTapWebButton(in cell: InformationCell, urlString: String) {
    guard let url = URL(string: urlString) else {
      print("Error: 유효하지 않은 url \(urlString)")
      return
    }

    // 외부 웹사이트로 이동
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
}
