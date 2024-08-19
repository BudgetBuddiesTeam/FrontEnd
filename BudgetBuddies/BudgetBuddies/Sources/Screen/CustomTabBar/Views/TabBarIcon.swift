//
//  TabBarIcon.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/19/24.
//

import UIKit
import SnapKit

class TabBarIcon: UIView {
    // MARK: - Properties
    private var size: Int
    private var tabBarIconColor: UIColor = BudgetBuddiesAsset.AppColor.barGray.color
    
    // MARK: - UI Components
    private let tabBarIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let tabBarLabel: UILabel = {
        let lb = UILabel()
        lb.text = " "
        lb.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
        lb.setCharacterSpacing(-0.35)
        return lb
    }()
    
    private lazy var tabBarStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [tabBarIconImageView, tabBarLabel])
        sv.axis = .vertical
        sv.spacing = 16
        sv.alignment = .center
        sv.distribution = .fill
        return sv
    }()
    
    // MARK: - Init
    init(tabBarIcon: UIImage, tabBarLabel: String, size: Int) {
        self.size = size
        super.init(frame: .zero)
        
        self.tabBarIconImageView.image = tabBarIcon
        self.tabBarLabel.text = tabBarLabel
        
        self.isUserInteractionEnabled = false
        
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        addSubview(tabBarStackView)
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        tabBarIconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(size)
        }
        
        tabBarLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
        }
        
        tabBarStackView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Update Appearance
    func updateAppearance(isSelected: Bool) {
        tabBarIconColor = isSelected ? BudgetBuddiesAsset.AppColor.coreYellow.color : BudgetBuddiesAsset.AppColor.barGray.color
        tabBarIconImageView.tintColor = tabBarIconColor
        tabBarLabel.textColor = tabBarIconColor
    }
}
