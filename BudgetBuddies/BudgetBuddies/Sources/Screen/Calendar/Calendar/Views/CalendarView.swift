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
    var contentView = UIView()
    
    // 콘텐트 뷰에 들어갈 컴포넌트들
    var bannerView = BannerView()
    var mainCalendarView = MainCalendarView()
    
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
        scrollView.addSubviews(contentView)
        
        // 콘텐트 뷰에 들어갈 컴포넌트
        contentView.addSubviews(bannerView,
                                mainCalendarView)
        
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
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        // 콘텐트 뷰에 들어갈 컴포넌트
        bannerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(127)
        }
        
        mainCalendarView.snp.makeConstraints { make in
            make.top.equalTo(bannerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(538)
        }
    }
}
