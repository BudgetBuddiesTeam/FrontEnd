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
        self.backgroundColor = .red
        
        self.addSubviews(bannerView)
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        bannerView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(127)
        }
    }
}
