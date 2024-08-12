//
//  CalendarView.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/12/24.
//

import UIKit
import SnapKit

class CalendarView: UIView {
    // MARK: - Properties
    
    // MARK: - UI Components
    // 스크롤뷰
    var scrollView = UIScrollView()
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews:
                                [bannerView,
                                 mainCalendarView,
                                 infoColorView,
                                 discountInfoTitleWithButtonView,
                                 discountInfoTableView])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 0
        return sv
    }()
    
    // 콘텐트 뷰에 들어갈 컴포넌트들
    var bannerView = BannerView()
    var mainCalendarView = MainCalendarView()
    var infoColorView = InfoColorView()
    var discountInfoTitleWithButtonView = InfoTitleWithButtonView(infoType: .discount)
    
    var discountInfoTableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        return tv
    }()
    
    // MARK: - Init ⭐️
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.backgroundColor = BudgetBuddiesAsset.AppColor.background.color
        
        // 스크롤 뷰
        self.addSubviews(scrollView)
        scrollView.addSubviews(stackView)
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        // 스크롤 뷰
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        // 콘텐트 뷰에 들어갈 컴포넌트
        bannerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(127)
        }
        
        mainCalendarView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(510)
        }
        
        infoColorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(29)
        }
        
        discountInfoTitleWithButtonView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(64)
        }
        
        discountInfoTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(168 + 168) // 일단 셀 두 개 높이로 설정
        }
    }
}
