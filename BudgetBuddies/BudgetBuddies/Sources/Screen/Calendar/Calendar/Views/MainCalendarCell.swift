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
            print("\(ymModel.month)년 \(ymModel.year)월 전달받음")
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
    
    
    // MARK: - 뒷 배경 margin
    var backViewMargin: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
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
    

  // MARK: - init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)

    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Set up UI
  private func setupUI() {
    self.backgroundColor = .clear
      self.contentView.addSubviews(backView)
      self.backView.addSubviews(backViewMargin, headerStackView)
      
    self.contentView.addSubviews(infoStackView)

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
