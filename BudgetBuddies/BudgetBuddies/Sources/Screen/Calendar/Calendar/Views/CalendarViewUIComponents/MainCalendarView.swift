//
//  MainCalendarView.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/12/24.
//

import SnapKit
import UIKit

class MainCalendarView: UIView {
  // MARK: - Properties
  // 주 배열
  let week = ["일", "월", "화", "수", "목", "금", "토"]

  var calendarHeight: Int = 510

  // 전달받을 년월
  var yearMonth: YearMonth? {
    didSet {
      guard let yearMonth = self.yearMonth else { return }
      calendarHeight = yearMonth.isSixWeeksLong() ? 590 : 510
      reSetupCalendarHeight()
      //      layoutSubviews()
    }
  }

  // networking
  var calendarInfos: MonthInfoDto? {
    didSet {
      guard let calendarInfos = calendarInfos else { return }
      setupRaisedInfoModels(calendarInfos: calendarInfos)
      layoutSubviews()
    }
  }

  // 캘린더에 올릴 정보 모델 (CalendarMonthInfoDto에서 걸러서 사용)
  var raisedInfoModels: [RaisedInfoModel] = []

  // UI Components
  // MARK: - 캘린더 뒷 배경
  var backView: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    view.layer.cornerRadius = 15

    view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
    view.layer.shadowOpacity = 1
    view.layer.shadowRadius = 5
    view.layer.shadowOffset = CGSize(width: 0, height: 0)
    view.layer.masksToBounds = false
    return view
  }()

  // MARK: - 년도, 월, 선택 버튼
  var yearMonthLabel: UILabel = {
    let lb = UILabel()
    lb.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 20)
    lb.setCharacterSpacing(-0.5)
    lb.textAlignment = .center

    lb.text = "0000.00"  // 받
    return lb
  }()

  var ChevronImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(systemName: "chevron.right")
    iv.tintColor = BudgetBuddiesAsset.AppColor.logoLine2.color
    iv.contentMode = .scaleAspectFill
    return iv
  }()

  lazy var yearMonthStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [yearMonthLabel, ChevronImageView])
    sv.axis = .horizontal
    sv.distribution = .fill
    sv.alignment = .center
    sv.spacing = 13
    sv.isUserInteractionEnabled = true
    return sv
  }()

  // MARK: - 주 스택뷰
  lazy var weekStackView: UIStackView = {
    let labels = week.map { day -> CustomDayLabel in
      let label = CustomDayLabel(dayOfWeek: day)
      return label
    }

    let sv = UIStackView(arrangedSubviews: labels)
    sv.axis = .horizontal
    sv.distribution = .fillEqually
    sv.alignment = .center
    sv.spacing = 0
    return sv
  }()

  // MARK: - headerView
  private lazy var headerStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [yearMonthStackView, weekStackView])
    sv.axis = .vertical
    sv.distribution = .fill
    sv.alignment = .center
    sv.spacing = 13
    return sv
  }()

  // MARK: - 뒷 배경 margin뷰
  // 캘린더 그리기 보조
  var backViewMargin: UIView = {
    let view = UIView()
    return view
  }()

  // MARK: - Init ⭐️
  override init(frame: CGRect) {
    super.init(frame: frame)

    setupUI()
  }

  override func layoutSubviews() {
    if let yearMonth = yearMonth {
      guard let year = yearMonth.year,
        let month = yearMonth.month
      else { return }

      setupDateOfCalendar(year: year, month: month)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Set up InfoModels
  private func setupRaisedInfoModels(calendarInfos: MonthInfoDto) {
    self.raisedInfoModels.removeAll()

    // 캘린더 할인정보, 지원정보 분리
    let discountCalendar = calendarInfos.discountInfoDtoList
    let supportCalendar = calendarInfos.supportInfoDtoList

    // 할인정보 생성
    for i in 0..<discountCalendar.count {
      let discounRaisedInfoModel = RaisedInfoModel(
        title: discountCalendar[i].title,
        startDate: discountCalendar[i].startDate,
        endDate: discountCalendar[i].endDate,
        infoType: .discount)

      self.raisedInfoModels.append(discounRaisedInfoModel)
    }

    // 지원정보 생성
    for i in 0..<supportCalendar.count {
      let supportRaisedInfoModel = RaisedInfoModel(
        title: supportCalendar[i].title,
        startDate: supportCalendar[i].startDate,
        endDate: supportCalendar[i].endDate,
        infoType: .support)

      self.raisedInfoModels.append(supportRaisedInfoModel)
    }

    // MARK: - Split & Sort 호출 ⭐️
    splitRaisedInfoModels(self.raisedInfoModels)
  }

  // MARK: - set up UI
  private func setupUI() {
    self.addSubviews(backView)
    backView.addSubviews(backViewMargin, headerStackView)

    setupConstraints()
  }

  // MARK: - Re Set up CalendarHeightConstraint
  private func reSetupCalendarHeight() {
    backView.snp.removeConstraints()
    backView.snp.remakeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(calendarHeight)
    }
  }

  // MARK: - set up Constraints
  private func setupConstraints() {
    // backView
    backView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(calendarHeight)
    }

    // headerView
    ChevronImageView.snp.makeConstraints { make in
      make.height.width.equalTo(12)
    }

    yearMonthStackView.snp.makeConstraints { make in
      make.height.equalTo(30)
    }

    weekStackView.snp.makeConstraints { make in
      make.leading.trailing.equalTo(backViewMargin)
      make.height.equalTo(40)
    }

    headerStackView.snp.makeConstraints { make in
      make.top.equalTo(backView.snp.top).inset(17)
      make.leading.trailing.equalTo(backViewMargin)
      make.centerX.equalToSuperview()
    }

    // 백뷰 margin
    backViewMargin.snp.makeConstraints { make in
      make.top.equalTo(headerStackView.snp.bottom)
      make.leading.trailing.equalToSuperview().inset(30)
      make.bottom.equalToSuperview()
    }
  }
}

// MARK: - Set up Date Of Calendar
extension MainCalendarView {
  private func setupDateOfCalendar(year: Int, month: Int) {
    backViewMargin.subviews.forEach { $0.removeFromSuperview() }

    // 달력 년월 텍스트 바꾸기
    self.yearMonthLabel.text = "\(year).\(String(format: "%02d", month))"

    // 달력 day 그리기
    // 그리드 생성
    let daysInWeek = 7
    let totalCells = 42  // 7일 * 6주(최대)
    let cellWidth = (self.backViewMargin.frame.width) / CGFloat(daysInWeek)  // 뷰 너비 / 7(일)
    let cellHeight = CGFloat(80)  // 임시로 너비와 같은 길이로 설정

    // 날짜 계산
    let components = DateComponents(year: year, month: month)  // 구조체 생성
    let calendar = Calendar.current  // 현재 사용 중인 캘린더 객체 반환 (ex 그리고리 달력)
    let firstOfMonth = calendar.date(from: components)!  // DateComponents -> Date객체로 변환 (07/01)
    let startDay = calendar.component(.weekday, from: firstOfMonth) - 1  // 시작 요일, 0: 일요일, 1: 월요일 ... 6: 토요일
    let numberOfDays = calendar.range(of: .day, in: .month, for: firstOfMonth)!.count  // 달에 몇일까지 있는지 (28, 30, 31...)

    var weeks: [[Int]] = Array(repeating: Array(repeating: 0, count: daysInWeek), count: 6)
    //            var dayCounter = 1
    //    var numberOfWeeks = 0

    // 날짜 레이블 추가
    for i in 0..<totalCells {  // 42개 셀
      let dayBackView: UIView = {
        let view = UIView()
        return view
      }()

      let dayLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textAlignment = .center
        return lb
      }()

      let day = i - startDay + 1
      if day > 0 && day <= numberOfDays {
        dayLabel.text = "\(day)"
        weeks[i / daysInWeek][i % daysInWeek] = day
      } else {
        dayLabel.text = ""
      }

      backViewMargin.addSubview(dayBackView)
      dayBackView.addSubview(dayLabel)

      dayBackView.snp.makeConstraints { make in
        make.width.equalTo(cellWidth)
        make.height.equalTo(cellHeight)
        make.leading.equalTo(backViewMargin.snp.leading).offset(CGFloat(i % daysInWeek) * cellWidth)
        make.top.equalTo(backViewMargin.snp.top).offset(CGFloat(i / daysInWeek) * cellHeight)
      }

      dayLabel.snp.makeConstraints { make in
        make.top.leading.trailing.equalToSuperview()
        make.height.equalTo(40)
      }
    }

    // MARK: - RaisedView 호출 부분 ⭐️
    updateOverlappedViews()
  }
}

extension MainCalendarView {
  // 겹침 여부에 따라 RaisedView 올리기
  func updateOverlappedViews() {
    // RaisedInfoModel의 겹침 여부를 저장하는 배열
    var isOverlappedFlags: [Bool] = Array(repeating: false, count: self.raisedInfoModels.count)

    for idx in 0..<self.raisedInfoModels.count {
      let currentModel = self.raisedInfoModels[idx]
      let currentStartDate = dateFromString(currentModel.startDate)
      let currentEndDate = dateFromString(currentModel.endDate)

      // 현재 일정의 겹침 여부를 초기화
      isOverlappedFlags[idx] = false

      // 이전 인덱스의 일정과 비교
      if idx > 0 {
        let previousModel = self.raisedInfoModels[idx - 1]
        let previousStartDate = dateFromString(previousModel.startDate)
        let previousEndDate = dateFromString(previousModel.endDate)

        if let currentStart = currentStartDate, let currentEnd = currentEndDate,
          let previousStart = previousStartDate, let previousEnd = previousEndDate
        {
          // 현재 일정이 이전 일정과 겹치는지 확인
          if currentStart <= previousEnd && currentEnd >= previousStart {
            // 이전 일정이 겹쳐있다면, 현재 일정의 겹침 여부를 false로 설정
            if isOverlappedFlags[idx - 1] {
              isOverlappedFlags[idx] = false
            } else {
              isOverlappedFlags[idx] = true
            }
          }
        }
      }

      setupRaisedViews(currentModel, isOverlapped: isOverlappedFlags[idx])
    }
  }
}

// MARK: - Set up Raised Views
extension MainCalendarView {
  // raisedInfoModel과 겹쳐있는지 여부에 따라 위치를 정함
  private func setupRaisedViews(_ raisedInfoModel: RaisedInfoModel, isOverlapped: Bool) {

    let infoType = raisedInfoModel.infoType
    guard let title = raisedInfoModel.title else { return }
    guard let startDatePosition = raisedInfoModel.startDatePosition() else { return }
    guard let endDatePosition = raisedInfoModel.endDatePosition() else { return }

    let widthInt = Int(backViewMargin.frame.width / 7)

    // RaisedInfoView를 생성하고 배치하는 함수
    func createRaisedView(topInsetBase: Int, row: Int, leadingInset: Int, trailingInset: Int)
      -> RaisedInfoView
    {
      let raisedView = RaisedInfoView(title: title, infoType: infoType)
      backViewMargin.addSubview(raisedView)
      raisedView.snp.makeConstraints { make in
        make.top.equalTo(headerStackView.snp.bottom).inset(topInsetBase - (80 * row))
        make.leading.equalToSuperview().inset(leadingInset + 1)
        make.trailing.equalToSuperview().inset(trailingInset + 1)
        make.height.equalTo(17)
      }
      return raisedView
    }

    // 한 줄짜리 일정을 그리는 코드
    _ = createRaisedView(
      topInsetBase: isOverlapped ? -61 : -40,
      row: startDatePosition.row,
      leadingInset: widthInt * startDatePosition.column,
      trailingInset: widthInt * (7 - endDatePosition.column - 1)
    )
  }
}

// MARK: - Sort RaisedInfoModels
extension MainCalendarView {
  private func splitRaisedInfoModels(_ raisedInfoModels: [RaisedInfoModel]) {
    // 분할 후 담을 곳
    var splitedRaisedInfoModels: [RaisedInfoModel] = []

    for i in 0..<raisedInfoModels.count {
      guard let numberOfRows = raisedInfoModels[i].numberOfRows() else { return }

      if numberOfRows == 1 {
        splitedRaisedInfoModels.append(raisedInfoModels[i])
      } else if numberOfRows >= 2 {
        for j in 0..<numberOfRows {
          splitedRaisedInfoModels.append(raisedInfoModels[i].splitIntoRows()[j])
        }
      }
    }

    self.raisedInfoModels.removeAll()
    self.raisedInfoModels = sortRaisedInfoModels(splitedRaisedInfoModels)
  }

  private func sortRaisedInfoModels(_ splitedRaisedInfoModels: [RaisedInfoModel])
    -> [RaisedInfoModel]
  {
    return splitedRaisedInfoModels.sorted { first, second in
      guard let firstDateString = first.startDate,
        let secondDateString = second.startDate,
        let firstDate = dateFromString(firstDateString),
        let secondDate = dateFromString(secondDateString)
      else {
        return false
      }
      return firstDate < secondDate
    }
  }
}

extension MainCalendarView {
  func dateFromString(_ dateString: String?) -> Date? {
    guard let dateString = dateString else { return nil }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: dateString)
  }
}
