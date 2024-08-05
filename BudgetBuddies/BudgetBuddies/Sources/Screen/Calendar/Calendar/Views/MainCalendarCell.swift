//
//  MainCalendarCell.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/25/24.
//

import SnapKit
import UIKit

protocol MainCalendarCellDelegate: AnyObject {
  func didTapSelectYearMonth(in cell: MainCalendarCell)
}

class MainCalendarCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "MainCalendarCell"

  weak var delegate: MainCalendarCellDelegate?

  let week = ["일", "월", "화", "수", "목", "금", "토"]

  var ymModel: YearMonth? {
    didSet {
      guard let ymModel = ymModel else { return }
      print("\(ymModel.year!)년 \(ymModel.month!)월 전달받음")
    }
  }

  var isSixWeek: Bool? {
    didSet {
      guard let isSixWeek = isSixWeek else { return }
      calendarHeight = isSixWeek ? 590 : 510
    }
  }

  var calendarHeight: Int? {
    didSet {
      reSetupBackViewConstraints()
    }
  }

  // 임시로 만들
  // 추후에 didSet을 통해 특정 월에 맞는 정보들만 받게끔 구현할 예정
  var infoModels: [InfoModel] = [
    InfoModel(
      title: "캘린더 너무 어려워요", startDate: "2024-07-02", endDate: "2024-07-05", infoType: .support),
    InfoModel(
      title: "하지만 해야지", startDate: "2024-07-07", endDate: "2024-07-10", infoType: .discount),
    InfoModel(
      title: "국가장학금 나줘요", startDate: "2024-07-14", endDate: "2024-07-18", infoType: .support),
    InfoModel(title: "어쩔거야", startDate: "2024-07-17", endDate: "2024-07-24", infoType: .discount),
    InfoModel(title: "안녕하세요", startDate: "2024-07-23", endDate: "2024-07-30", infoType: .support),
  ]

  // UI Components
  // MARK: - 뒷 배경
  var backView: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    view.layer.cornerRadius = 15

    view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
    view.layer.shadowOpacity = 1
    view.layer.shadowRadius = 5  //반경
    view.layer.shadowOffset = CGSize(width: 0, height: 0)  //위치조정
    view.layer.masksToBounds = false  //
    return view
  }()

  // MARK: - 년도, 월, 선택 버튼
  var yearMonthLabel: UILabel = {
    let lb = UILabel()
    lb.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 20)
    lb.setCharacterSpacing(-0.5)
    lb.textAlignment = .center

    lb.text = " "  // 받
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

    let tapGesture = UITapGestureRecognizer(
      target: self, action: #selector(didtapYearMonthStackView))
    sv.addGestureRecognizer(tapGesture)
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

  // MARK: - HeaderView
  private lazy var headerStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [yearMonthStackView, weekStackView])
    sv.axis = .vertical
    sv.distribution = .fill
    sv.alignment = .center
    sv.spacing = 13
    return sv
  }()

  // MARK: - 뒷 배경 margin 뷰
  var backViewMargin: UIView = {
    let view = UIView()
    //      view.layer.borderColor = UIColor.red.cgColor
    //      view.layer.borderWidth = 1.0
    return view
  }()

  // 할인정보, 지원정보
  var discountInfo = CustomInfoColor(infoType: .discount)
  var supportInfo = CustomInfoColor(infoType: .support)

  lazy var infoStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [discountInfo, supportInfo])
    sv.axis = .horizontal
    sv.spacing = 11
    sv.alignment = .center
    sv.distribution = .fill
    return sv
  }()

  // MARK: - init ⭐️⭐️⭐️
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)

    setupUI()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    // layoutSubviews가 호출될 때 백그라운드 뷰의 크기를 다시 설정
    backView.setNeedsLayout()
    backView.layoutIfNeeded()

    if let ymModel = ymModel {
      guard let year = ymModel.year else { return }
      guard let month = ymModel.month else { return }
      setupDateOfCalendar(year: year, month: month)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - Set up Date of Calendar
  private func setupDateOfCalendar(year: Int, month: Int) {
    backViewMargin.subviews.forEach { $0.removeFromSuperview() }

    self.yearMonthLabel.text = "\(year).\(String(format: "%02d", month))"

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

    // raisedView 올리기
    // 겹치는 일정인지 확인하기
    // 추가 개발해야하는 거
    // 3 일정이 연달아 겹치는 경우
    for idx in 0..<infoModels.count {
      let currentModel = infoModels[idx]
      let currentStartDate = dateFromString(currentModel.startDate)
      let currentEndDate = dateFromString(currentModel.endDate)
      var isOverlapped = false

      for otherIdx in 0..<infoModels.count {
        if idx == otherIdx { continue }

        let otherModel = infoModels[otherIdx]
        let otherStartDate = dateFromString(otherModel.startDate)
        let otherEndDate = dateFromString(otherModel.endDate)

        if let currentStart = currentStartDate, let currentEnd = currentEndDate,
          let otherStart = otherStartDate, let otherEnd = otherEndDate
        {
          if currentStart <= otherEnd && currentEnd >= otherStart {
            if currentStart > otherStart {
              isOverlapped = true
              break
            }
          }
        }
      }

      setupRaisedViews(currentModel, isOverlapped: isOverlapped)
    }
  }
  func dateFromString(_ dateString: String?) -> Date? {
    guard let dateString = dateString else { return nil }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: dateString)
  }

  // MARK: - Set up RaisedViews
  private func setupRaisedViews(_ infoModel: InfoModel, isOverlapped: Bool) {
    let infoType = infoModel.infoType
    guard let title = infoModel.title else { return }
    guard let startDatePosition = infoModel.startDatePosition() else { return }
    guard let endDatePosition = infoModel.endDatePosition() else { return }
    guard let numberOfRows = infoModel.numberOfRows() else { return }

    let widthInt = Int(backViewMargin.frame.width / 7)
    //        let topInsetBase = isOverlapped ? -61 : -40

    func createRaisedView(topInsetBase: Int, row: Int, leadingInset: Int, trailingInset: Int)
      -> RaisedInfoView
    {
      let raisedView = RaisedInfoView(title: title, infoType: infoType)
      backViewMargin.addSubview(raisedView)
      raisedView.snp.makeConstraints { make in
        make.top.equalTo(headerStackView.snp.bottom).inset(topInsetBase - (80 * row))
        make.leading.equalToSuperview().inset(leadingInset)
        make.trailing.equalToSuperview().inset(trailingInset)
        make.height.equalTo(17)
      }
      return raisedView
    }

    if numberOfRows == 1 {
      _ = createRaisedView(
        topInsetBase: isOverlapped ? -61 : -40,
        row: startDatePosition.row,
        leadingInset: widthInt * startDatePosition.column,
        trailingInset: widthInt * (7 - endDatePosition.column - 1)
      )
    } else {
      _ = createRaisedView(
        topInsetBase: isOverlapped ? -61 : -40,
        row: startDatePosition.row,
        leadingInset: widthInt * startDatePosition.column,
        trailingInset: 0
      )
      if numberOfRows >= 3 {
        for i in 1..<numberOfRows - 1 {
          _ = createRaisedView(
            topInsetBase: -40,
            row: startDatePosition.row + i,
            leadingInset: 0,
            trailingInset: 0
          )
        }
      }
      _ = createRaisedView(
        topInsetBase: -40,
        row: startDatePosition.row + numberOfRows - 1,
        leadingInset: 0,
        trailingInset: widthInt * (7 - endDatePosition.column - 1)
      )
    }
  }
  //    private func setupRaisedViews(_ infoModel: InfoModel, isOverLapped: Bool) {
  //
  //        let infoType = infoModel.infoType
  //        guard let title = infoModel.title else { return }
  //        guard let startDatePosition = infoModel.startDatePosition() else { return } // .row: 0 = 1번줄 .column: 0 = 1번째
  //        guard let endDatePosition = infoModel.endDatePosition() else { return } // 0 = 1번째
  //
  //        let widthInt = Int(backViewMargin.frame.width / 7) // 7일로 나눔
  //
  //        // 얘를 들어 지금 7월 7일이 2번째 줄 1번째 위치라고 하면
  //
  //        guard let numberOfRows = infoModel.numberOfRows() else { return }
  //
  //        if numberOfRows == 1 {
  //            // 한 줄에 걸쳐있으면 하나만 생성
  //            let raisedView = RaisedInfoView(title: title, infoType: infoType)
  //            backViewMargin.addSubview(raisedView)
  //            raisedView.snp.makeConstraints { make in
  //                make.top.equalTo(headerStackView.snp.bottom).inset(
  //                    isOverLapped ? -61 - (80 * (startDatePosition.row)) : -40 - (80 * (startDatePosition.row))
  //                )
  //                make.leading.equalToSuperview().inset(widthInt * startDatePosition.column) // widthInt를 기준으로 *연산으로 inset값 정함
  //                make.trailing.equalToSuperview().inset(widthInt * (7 - endDatePosition.column - 1)) // 7 - widthInt
  //                make.height.equalTo(17)
  //            }
  //
  //        } else {
  //            let firstRaisedView = RaisedInfoView(title: title, infoType: infoType)
  //            backViewMargin.addSubview(firstRaisedView)
  //            firstRaisedView.snp.makeConstraints { make in
  //                make.top.equalTo(headerStackView.snp.bottom).inset(
  //                    isOverLapped ? -61 - (80 * (startDatePosition.row)) : -40 - (80 * (startDatePosition.row))
  //                )
  //                make.leading.equalToSuperview().inset(widthInt * startDatePosition.column) // widthInt를 기준으로 *연산으로 inset값 정함
  //                make.trailing.equalToSuperview().inset(0)
  //                make.height.equalTo(17)
  //            }
  //
  //            // 중간 뷰 그리기
  //            if numberOfRows >= 3 {
  //                for i in 1..<numberOfRows - 1 {
  //                    let middleRaisedView = RaisedInfoView(title: title, infoType: infoType)
  //                    backViewMargin.addSubview(middleRaisedView)
  //                    middleRaisedView.snp.makeConstraints { make in
  //                        make.top.equalTo(headerStackView.snp.bottom).inset(
  //                            isOverLapped ? -61 - (80 * (startDatePosition.row + i)) : -40 - (80 * (startDatePosition.row + i))
  //                        )
  //                        make.leading.trailing.equalToSuperview().inset(0)
  //                    }
  //                }
  //
  //            }
  //
  //            let lastRaisedView = RaisedInfoView(title: title, infoType: infoType)
  //            backViewMargin.addSubview(lastRaisedView)
  //            lastRaisedView.snp.makeConstraints { make in
  //                make.top.equalTo(headerStackView.snp.bottom).inset(
  //                    isOverLapped ? -61 - (80 * (startDatePosition.row - 1)) : -40 - (80 * (startDatePosition.row - 1))
  //                )
  //                make.leading.equalToSuperview().inset(0)
  //                make.trailing.equalToSuperview().inset(widthInt * (7 - endDatePosition.column - 1)) // 7 - widthInt
  //                make.height.equalTo(17)
  //            }
  //        }
  //    }

  // MARK: - Set up UI
  private func setupUI() {
    self.backgroundColor = .clear
    self.contentView.addSubviews(backView, infoStackView)
    self.backView.addSubviews(backViewMargin, headerStackView)

    setupConstraints()
  }

  private func reSetupBackViewConstraints() {
    backView.snp.removeConstraints()
    backView.snp.remakeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(16)
      guard let calendarHeight = calendarHeight else { return }
      make.height.equalTo(calendarHeight)
    }
  }

  // MARK: - Set up Constraints
  private func setupConstraints() {
    // 캘린더 백뷰
    backView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(16)
      guard let calendarHeight = calendarHeight else { return }
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

    // 할인정보, 지원정보
    infoStackView.snp.makeConstraints { make in
      make.top.equalTo(backView.snp.bottom).offset(7)
      make.leading.equalTo(backView.snp.leading).inset(11)
      make.height.equalTo(15)
      make.bottom.equalToSuperview().inset(6)  // 셀의 bottom과 간격
    }
  }

  // MARK: - Selectors
  @objc
  private func didtapYearMonthStackView() {
    delegate?.didTapSelectYearMonth(in: self)
  }
}
