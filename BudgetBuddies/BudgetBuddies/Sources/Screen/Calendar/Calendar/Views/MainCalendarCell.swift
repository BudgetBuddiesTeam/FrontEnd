//
//  MainCalendarCell.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/25/24.
//

import SnapKit
import UIKit

class MainCalendarCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "MainCalendarCell"
    
    let week = ["일", "월", "화", "수", "목", "금", "토"]
    
    var ymModel: YearMonth? {
        didSet {
            guard let ymModel = ymModel else { return }
            print("\(ymModel.year!)년 \(ymModel.month!)월 전달받음")
        }
    }

  // UI Components
  // MARK: - 뒷 배경
  var backView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 15

    view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
    view.layer.shadowOpacity = 1
    view.layer.shadowRadius = 5  //반경
    view.layer.shadowOffset = CGSize(width: 0, height: 0)  //위치조정
    view.layer.masksToBounds = false  //
    return view
  }()
    
    // MARK: - 년도, 월,  선택 버튼
    var yearMonthLabel: UILabel = {
        let lb = UILabel()
        lb.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 20)
        lb.setCharacterSpacing(-0.5)
        lb.textAlignment = .center
        
        lb.text = "2024.09" // 받
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
//        sv.layer.borderWidth = 1.0
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
        
        print("달력 날짜 생성")
        self.yearMonthLabel.text = "\(year).\(String(format: "%02d", month))"
        
        // 그리드 생성
        let daysInWeek = 7
        let totalCells = 42 // 7일 * 6주(최대)
        let cellWidth = (self.backViewMargin.frame.width) / CGFloat(daysInWeek) // 뷰 너비 / 7(일)
        let cellHeight = CGFloat(80) // 임시로 너비와 같은 길이로 설정
        
        // 날짜 계산
        let components = DateComponents(year: year, month: month) // 구조체 생성
        let calendar = Calendar.current // 현재 사용 중인 캘린더 객체 반환 (ex 그리고리 달력)
        let firstOfMonth = calendar.date(from: components)! // DateComponents -> Date객체로 변환 (07/01)
        let startDay = calendar.component(.weekday, from: firstOfMonth) - 1 // 시작 요일, 0: 일요일, 1: 월요일 ... 6: 토요일
        let numberOfDays = calendar.range(of: .day, in: .month, for: firstOfMonth)!.count // 달에 몇일까지 있는지 (28, 30, 31...)
        
        var weeks: [[Int]] = Array(repeating: Array(repeating: 0, count: daysInWeek), count: 6)
        var dayCounter = 1
        var numberOfWeeks = 0
        
        // 날짜 레이블 추가
        for i in 0..<totalCells { // 42개 셀
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
//            delegate?.didEncounterSixWeekMonth(in: self)
        }
    }

  // MARK: - Set up UI
  private func setupUI() {
    self.backgroundColor = .clear
      self.contentView.addSubviews(backView, infoStackView)
      self.backView.addSubviews(backViewMargin, headerStackView)
      

    setupConstraints()
  }

  // MARK: - Set up Constraints
  private func setupConstraints() {
    // 캘린더 백뷰
    backView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(510)
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
    }

  }
}
