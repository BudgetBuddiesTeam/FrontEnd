//
//  MainCalendarView.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/12/24.
//

import UIKit
import SnapKit

class MainCalendarView: UIView {
    // MARK: - Properties
    let week = ["일", "월", "화", "수", "목", "금", "토"]
    
    // 전달받을 년월
    var yearMonth: YearMonth? {
        didSet {
            guard let yearMonth = yearMonth else { return }
            print("MainCalendarView: \(yearMonth.year!)년 \(yearMonth.month!)월")
        }
    }
    
    // MARK: - UI Components
    // 캘린더 뒷 배경
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
    
    // 년도, 월, 선택 버튼
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
        
//        let tapGesture = UITapGestureRecognizer(
//            target: self, action: #selector(didtapYearMonthStackView))
//        sv.addGestureRecognizer(tapGesture)
//        sv.isUserInteractionEnabled = true
        
        return sv
    }()
    
    // 주 스택뷰
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
    
    // headerView
    private lazy var headerStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [yearMonthStackView, weekStackView])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 13
        return sv
    }()
    
    // 뒷 배경 margin뷰 (좀 더 쉽게 캘린더를 그리기 위함)
    var backViewMargin: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.0
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set up UI
    private func setupUI() {
        self.addSubviews(backView)
        backView.addSubviews(backViewMargin, headerStackView)
        
        setupConstraints()
    }
    
    // MARK: - set up Constraints
    private func setupConstraints() {
        // backView
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
        
    }
}
