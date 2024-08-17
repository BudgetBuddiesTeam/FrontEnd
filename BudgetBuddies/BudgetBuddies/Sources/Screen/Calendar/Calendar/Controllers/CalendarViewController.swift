//
//  CalendarViewController.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/12/24.
//

import UIKit

final class CalendarViewController: UIViewController {
  // MARK: - Properties
  var yearMonth: YearMonth? {
    didSet {
      setupData()
      calendarView.yearMonth = self.yearMonth
    }
  }

  // networking
  var calendarManager = CalendarManager.shared
  var discountRecommends: [InfoDtoList] = []
  var supportRecommends: [InfoDtoList] = []
  var calendarInfos: MonthInfoDto?

  // MARK: - UI Components
  // 뷰
  var calendarView = CalendarView()

  // MARK: - Life Cycle ⭐️
  override func loadView() {
    self.view = calendarView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupNowYearMonth()
    //    setupData()
    setupTableViews()
    setupButtonActions()
    setupNavigationBar()
    setupNotificationCenterObservers()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    setupNavigationBar()
  }

  deinit {
    // 노티 remove (메모리 누수 방지)
    NotificationCenter.default.removeObserver(
      self, name: NSNotification.Name("MainToCalendar"), object: nil)
    NotificationCenter.default.removeObserver(
      self, name: NSNotification.Name("AllLookingToCalendar"), object: nil)
  }

  // MARK: - Set up NotificationCenterObservers
  // 노티 등록
  private func setupNotificationCenterObservers() {
    NotificationCenter.default.addObserver(
      self, selector: #selector(switchToCalendarHandler),
      name: NSNotification.Name("MainToCalendar"), object: nil)

    NotificationCenter.default.addObserver(
      self, selector: #selector(switchToCalendarHandler),
      name: NSNotification.Name("AllLookingToCalendar"), object: nil)
  }

  // MARK: - Set up Now YearMonth
  func setupNowYearMonth() {
    self.yearMonth = YearMonth.setNowYearMonth()
  }

  // MARK: - Set up Data
  private func setupData() {
    print("-----------캘린더 메인 fetch-----------")
    guard let yearMonth = self.yearMonth else { return }

    calendarManager.fetchCalendar(request: yearMonth) { result in
      switch result {
      case .success(let response):
        print("데이터 디코딩 성공")
        self.discountRecommends = response.result.recommendMonthInfoDto.discountInfoDtoList
        self.supportRecommends = response.result.recommendMonthInfoDto.supportInfoDtoList
        self.calendarInfos = response.result.calendarMonthInfoDto

        DispatchQueue.main.async {
          // 캘린더 api
          self.calendarView.mainCalendarView.calendarInfos = self.calendarInfos

          // 추천 api
          // 데이터 개수에 따라 테이블 뷰 높이 설정
          let discountCount = self.discountRecommends.count
          let supportCount = self.supportRecommends.count
          self.calendarView.discountTableViewHeight = discountCount == 0 ? 168 : discountCount * 168
          self.calendarView.supportTableViewHeight = supportCount == 0 ? 168 : supportCount * 168

          // 데이터 유무에 따라 전체보기 활성화 여부 전달
          let discountInfoListEnabled = self.discountRecommends.count == 0 ? false : true
          let supportInfoListEnabled = self.supportRecommends.count == 0 ? false : true
          self.calendarView.discountInfoTitleWithButtonView.isEnabled = discountInfoListEnabled
          self.calendarView.supportInfoTitleWithButtonView.isEnabled = supportInfoListEnabled

          // 테이블 뷰 리로드
          self.calendarView.discountInfoTableView.reloadData()
          self.calendarView.supportInfoTableView.reloadData()
        }

      case .failure(let error):
        print("데이터 디코딩 실패")
        print(error.localizedDescription)
      }
    }
  }

  // MARK: - Set up TableViews
  private func setupTableViews() {
    // 할인정보 테이블 뷰
    let discountTV = calendarView.discountInfoTableView
    discountTV.delegate = self
    discountTV.dataSource = self

    // 지원정보 테이블 뷰
    let supportTV = calendarView.supportInfoTableView
    supportTV.delegate = self
    supportTV.dataSource = self

    // 셀 등록
    registerCells()

  }

  // MARK: - Register Cells
  private func registerCells() {
    let discountTV = calendarView.discountInfoTableView
    discountTV.register(InformationCell.self, forCellReuseIdentifier: InformationCell.identifier)
    discountTV.register(ReadyInfoCell.self, forCellReuseIdentifier: ReadyInfoCell.identifier)

    let supportTV = calendarView.supportInfoTableView
    supportTV.register(InformationCell.self, forCellReuseIdentifier: InformationCell.identifier)
    supportTV.register(ReadyInfoCell.self, forCellReuseIdentifier: ReadyInfoCell.identifier)

  }

  // MARK: - Set up Button Actions
  // 뷰컨에서 버튼 액션 관리 (MVC 패턴)
  private func setupButtonActions() {
    // 할인정보 전체보기 제스처
    let discountDetailTapGesture = UITapGestureRecognizer(
      target: self, action: #selector(didTapShowDiscountDetail))
    calendarView.discountInfoTitleWithButtonView.showDetailStackView.addGestureRecognizer(
      discountDetailTapGesture)

    // 지원정보 전체보기 제스처
    let supportDetailTapGesture = UITapGestureRecognizer(
      target: self, action: #selector(didTapShowSupportDetail))
    calendarView.supportInfoTitleWithButtonView.showDetailStackView.addGestureRecognizer(
      supportDetailTapGesture)

    // 캘린더 선택 제스처
    let selectCalendarTapGesture = UITapGestureRecognizer(
      target: self, action: #selector(didTapSelectCalendar))
    calendarView.mainCalendarView.yearMonthStackView.addGestureRecognizer(selectCalendarTapGesture)

    // 버튼 액션
  }

  // MARK: - Set up Navigation Bar
  private func setupNavigationBar() {
    navigationController?.navigationBar.isHidden = true
  }

  // MARK: - Selectors
  // 할인정보 전체보기
  @objc
  private func didTapShowDiscountDetail() {

    // 할인정보가 하나라도 있으면 전체보기
    if discountRecommends.count >= 1 {
      let vc = InfoListViewController(infoType: .discount)
      vc.yearMonth = self.yearMonth
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }

  // 지원정보 전체보기
  @objc
  private func didTapShowSupportDetail() {

    // 지원정보가 하나라도 있으면 전체보기
    if supportRecommends.count >= 1 {
      let vc = InfoListViewController(infoType: .support)
      vc.yearMonth = self.yearMonth
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }

  // 날짜 선택
  @objc
  private func didTapSelectCalendar() {
    print(#function)
    let vc = MonthPickerViewController()
    vc.yearMonth = yearMonth

    vc.delegate = self
    self.present(vc, animated: true, completion: nil)
  }

  @objc
  private func switchToCalendarHandler() {
    setupNowYearMonth()
  }
}

// MARK: - UITableView DataSource
extension CalendarViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == calendarView.discountInfoTableView {
      let discountCount = discountRecommends.count == 0 ? 1 : discountRecommends.count
      return discountCount
    }

    if tableView == calendarView.supportInfoTableView {
      let supportCount = supportRecommends.count == 0 ? 1 : supportRecommends.count
      return supportCount
    }

    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // 할인정보 테이블 뷰
    if tableView == calendarView.discountInfoTableView {
      if indexPath.row < discountRecommends.count {
        let cell =
          tableView.dequeueReusableCell(withIdentifier: InformationCell.identifier, for: indexPath)
          as! InformationCell
        cell.configure(infoType: .discount)

        // 대리자
        cell.delegate = self

        // 데이터 전달
        let discountRecommend = self.discountRecommends[indexPath.row]
        cell.recommend = discountRecommend

        cell.selectionStyle = .none
        return cell

      } else {
        let cell =
          tableView.dequeueReusableCell(withIdentifier: ReadyInfoCell.identifier, for: indexPath)
          as! ReadyInfoCell
        cell.configure(infoType: .discount)

        cell.selectionStyle = .none
        return cell
      }
    }

    // 지원정보 테이블 뷰
    if tableView == calendarView.supportInfoTableView {
      if indexPath.row < supportRecommends.count {
        let cell =
          tableView.dequeueReusableCell(withIdentifier: InformationCell.identifier, for: indexPath)
          as! InformationCell
        cell.configure(infoType: .support)

        // 대리자
        cell.delegate = self

        // 데이터 전달
        let supportRecommend = self.supportRecommends[indexPath.row]
        cell.recommend = supportRecommend

        cell.selectionStyle = .none
        return cell

      } else {
        let cell =
          tableView.dequeueReusableCell(withIdentifier: ReadyInfoCell.identifier, for: indexPath)
          as! ReadyInfoCell
        cell.configure(infoType: .support)

        cell.selectionStyle = .none
        return cell
      }
    }

    return UITableViewCell()
  }
}

// MARK: - UITableView Delegate
extension CalendarViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 168
  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == calendarView.discountInfoTableView, self.discountRecommends.count != 0 {
            let infoId = self.discountRecommends[indexPath.row].id
            let vc = BottomSheetViewController(infoType: .discount, infoId: infoId)
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
        if tableView == calendarView.supportInfoTableView, self.supportRecommends.count != 0 {
            let infoId = self.supportRecommends[indexPath.row].id
            let vc = BottomSheetViewController(infoType: .support, infoId: infoId)
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension CalendarViewController: MonthPickerViewControllerDelegate {
  // MonthPickerViewController에서 년월 선택버튼 누르는 시점
  func didTapSelectButton(year: Int, month: Int) {
    self.yearMonth = YearMonth(year: year, month: month)
  }
}

extension CalendarViewController: InformationCellDelegate {
  func didTapWebButton(in cell: InformationCell, urlString: String) {
    guard let url = URL(string: urlString) else {
      print("Error: 유효하지 않은 url \(urlString)")
      return
    }

    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }

}
