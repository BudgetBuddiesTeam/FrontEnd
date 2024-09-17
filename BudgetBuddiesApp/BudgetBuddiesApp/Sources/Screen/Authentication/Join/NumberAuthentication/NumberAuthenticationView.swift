//
//  NumberAuthenticationView.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/17/24.
//

import UIKit
import SnapKit

class NumberAuthenticationView: UIView {
    // MARK: - UI Components
    let stepDot = StepDotView(steps: .firstStep)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
        
        self.addSubviews(stepDot)
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        stepDot.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(32)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(8)
        }
    }
}
