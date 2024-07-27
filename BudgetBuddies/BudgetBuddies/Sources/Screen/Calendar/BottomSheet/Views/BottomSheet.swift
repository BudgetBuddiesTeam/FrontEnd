//
//  BottomSheet.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/27/24.
//

import UIKit
import SnapKit

class BottomSheet: UIView {
    // MARK: - Properties
    private var heightConstraint: Constraint?
    
    // MARK: - UI Components
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = BudgetBuddiesAsset.AppColor.white.color
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 24
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
    
    // MARK: - Set up UI
    private func setupUI() {
        self.addSubviews(backView)
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
