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
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    var bannerView = BannerView()
    
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
        
        self.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        
        contentView.addSubviews(bannerView)
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        bannerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(127)
        }
    }
}
