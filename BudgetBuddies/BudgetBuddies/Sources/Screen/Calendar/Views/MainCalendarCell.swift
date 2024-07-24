//
//  MainCalendarCell.swift
//  BudgetBuddiesLocal
//
//  Created by 김승원 on 7/15/24.
//

import UIKit

protocol MainCalendarCellDelegate: AnyObject {
  func didTapSelectMonthButton(in cell: MainCalendarCell)
  func didEncounterSixWeekMonth(in cell: MainCalendarCell)
}

final class MainCalendarCell: UITableViewCell {
  weak var delegate: MainCalendarCellDelegate?

  var year: Int? = 2024 {  // 일단 옵셔널로 안 함
    didSet {
      configureCalendar()
    }
  }

  var month: Int? = 7 {
    didSet {  // cell에 새로 선택된 달이 들어온다면
      configureCalendar()
      //            print("\(month!)전달 받음")
    }
  }

  // MARK: - BackView
  private let backView: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
    view.layer.cornerRadius = 15

    view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
    view.layer.shadowOpacity = 1
    view.layer.shadowRadius = 5  //반경
    view.layer.shadowOffset = CGSize(width: 0, height: 0)  //위치조정
    view.layer.masksToBounds = false  //
    return view
  }()

  private let backViewMargin: UIView = {
    let view = UIView()
    //        view.backgroundColor = .lightGray
    return view
  }()

  // MARK: - 요일 Label
  private let sunLabel: UILabel = {
    let lb = UILabel()
    lb.font = UIFont(name: "Pretendard-Regular", size: 16)
    lb.textColor = #colorLiteral(
      red: 0.4627450705, green: 0.4627450705, blue: 0.4627450705, alpha: 1)
    lb.text = "일"
    lb.textAlignment = .center
    return lb
  }()
  private let monLabel: UILabel = {
    let lb = UILabel()
    lb.font = UIFont(name: "Pretendard-Regular", size: 16)
    lb.textColor = #colorLiteral(
      red: 0.4627450705, green: 0.4627450705, blue: 0.4627450705, alpha: 1)
    lb.text = "월"
    lb.textAlignment = .center
    return lb
  }()
  private let tueLabel: UILabel = {
    let lb = UILabel()
    lb.font = UIFont(name: "Pretendard-Regular", size: 16)
    lb.textColor = #colorLiteral(
      red: 0.4627450705, green: 0.4627450705, blue: 0.4627450705, alpha: 1)
    lb.text = "화"
    lb.textAlignment = .center
    return lb
  }()
  private let wedLabel: UILabel = {
    let lb = UILabel()
    lb.font = UIFont(name: "Pretendard-Regular", size: 16)
    lb.textColor = #colorLiteral(
      red: 0.4627450705, green: 0.4627450705, blue: 0.4627450705, alpha: 1)
    lb.text = "수"
    lb.textAlignment = .center
    return lb
  }()
  private let thuLabel: UILabel = {
    let lb = UILabel()
    lb.font = UIFont(name: "Pretendard-Regular", size: 16)
    lb.textColor = #colorLiteral(
      red: 0.4627450705, green: 0.4627450705, blue: 0.4627450705, alpha: 1)
    lb.text = "목"
    lb.textAlignment = .center
    return lb
  }()
  private let friLabel: UILabel = {
    let lb = UILabel()
    lb.font = UIFont(name: "Pretendard-Regular", size: 16)
    lb.textColor = #colorLiteral(
      red: 0.4627450705, green: 0.4627450705, blue: 0.4627450705, alpha: 1)
    lb.text = "금"
    lb.textAlignment = .center
    return lb
  }()
  private let satLabel: UILabel = {
    let lb = UILabel()
    lb.font = UIFont(name: "Pretendard-Regular", size: 16)
    lb.textColor = #colorLiteral(
      red: 0.4627450705, green: 0.4627450705, blue: 0.4627450705, alpha: 1)
    lb.text = "토"
    lb.textAlignment = .center
    return lb
  }()

  // MARK: - Week StackView
  private lazy var weekStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [
      sunLabel, monLabel, tueLabel, wedLabel, thuLabel, friLabel, satLabel,
    ])
    sv.axis = .horizontal
    sv.distribution = .fillEqually
    sv.alignment = .center
    sv.spacing = 0
    //        sv.layer.borderWidth = 1.0
    return sv
  }()

  // 년도, 월, 버튼
  let yearMonthLabel: UILabel = {
    let lb = UILabel()
    lb.font = UIFont(name: "Pretendard-SemiBold", size: 20)
    lb.textAlignment = .center
    //        lb.text = "2024.09" // 받
    let attributedString = NSMutableAttributedString(string: lb.text ?? "")
    let letterSpacing: CGFloat = -0.5
    attributedString.addAttribute(
      .kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
    return lb
  }()

  private lazy var selectMonthButton: UIButton = {
    let btn = UIButton()
    btn.setImage(UIImage(named: "chevron.left.yellow"), for: .normal)
    btn.contentMode = .scaleAspectFill
    btn.addTarget(self, action: #selector(didTapselectMonthButton), for: .touchUpInside)
    return btn
  }()

  // MARK: - Year Month selectMonthButton StackView
  private lazy var yearMonthStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [yearMonthLabel, selectMonthButton])
    sv.axis = .horizontal
    sv.distribution = .fill
    sv.alignment = .center
    sv.spacing = 13
    //        sv.layer.borderWidth = 1.0
    return sv
  }()

  // MARK: - Header StackView
  private lazy var headerStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [yearMonthStackView, weekStackView])
    sv.axis = .vertical
    sv.distribution = .fill
    sv.alignment = .center
    sv.spacing = 13
    return sv
  }()

  // MARK: - 할인정보, 지원정보
  private let discountInfo = CustomInfoColorView(infoType: .discount, infoText: "할인정보")
  private let supportInfo = CustomInfoColorView(infoType: .support, infoText: "지원정보")

  lazy var stackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [discountInfo, supportInfo])
    sv.axis = .horizontal
    sv.spacing = 11
    sv.alignment = .center
    sv.distribution = .fill
    return sv
  }()

  // MARK: - override init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = .none
    print(#function)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    guard let year = year, let month = month else { return }
    setupDateOfCalendar(year: year, month: month)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    yearMonthLabel.text = nil
    month = nil
    backViewMargin.subviews.forEach { $0.removeFromSuperview() }
  }

  // MARK: - Set up UI
  private func setupUI() {
    self.subviews.forEach { $0.removeFromSuperview() }
    self.backgroundColor = .clear
    self.contentView.addSubview(backView)
    self.backView.addSubview(backViewMargin)
    self.backView.addSubview(headerStackView)

    self.addSubview(stackView)

    setupConstraints()
  }

  // MARK: - configureCalendar
  private func configureCalendar() {
    guard let year = year, let month = month else { return }
    print("MainCalendarCell: \(year).\(month) 설정됨")
    yearMonthLabel.text = "\(year).\(String(format: "%02d", month))"

    if backViewMargin.subviews.isEmpty {
      setupDateOfCalendar(year: year, month: month)
    }
  }

  // MARK: - Set up Date of Calendar
  func setupDateOfCalendar(year: Int, month: Int) {

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
    var dayCounter = 1
    var numberOfWeeks = 0

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

    // 주 수 계산
    for week in weeks {
      if week.contains(where: { $0 != 0 }) {
        numberOfWeeks += 1
      }
    }

    // 6주 이상 출력되는 달을 감지하여 출력
    if numberOfWeeks > 5 {
      print("\(year)년 \(month)월은 6줄 이상")
      delegate?.didEncounterSixWeekMonth(in: self)
    }
  }

  // MARK: - Set up Constraints
  private func setupConstraints() {
    // 캘린더 백뷰
    backView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(510)
    }

    // 캘린더 백뷰 마진
    backViewMargin.snp.makeConstraints { make in
      make.top.equalTo(headerStackView.snp.bottom)
      make.leading.trailing.equalToSuperview().inset(30)
      make.bottom.equalToSuperview()
    }

    selectMonthButton.snp.makeConstraints { make in
      make.height.equalTo(22)
      make.width.equalTo(11)
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

    // 할인정보, 지원정보
    stackView.snp.makeConstraints { make in
      make.top.equalTo(backView.snp.bottom).offset(7)
      make.leading.equalTo(backView.snp.leading).inset(11)
    }
  }

  // MARK: - Selectors
  @objc private func didTapselectMonthButton() {
    print(#function)
    delegate?.didTapSelectMonthButton(in: self)
  }
}
