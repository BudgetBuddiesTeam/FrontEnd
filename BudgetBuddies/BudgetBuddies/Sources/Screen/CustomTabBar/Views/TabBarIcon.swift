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
    var size: Int
    var tabBarIconColor = BudgetBuddiesAsset.AppColor.barGray.color
    
    // MARK: - UI Components
    var tabBarIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = BudgetBuddiesAsset.AppColor.barGray.color
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    var tabBarLabel: UILabel = {
        let lb = UILabel()
        lb.text = " "
        lb.textColor = BudgetBuddiesAsset.AppColor.barGray.color
        lb.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
        lb.setCharacterSpacing(-0.35)
        return lb
    }()
    
    lazy var tabBarStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [tabBarIconImageView, tabBarLabel])
        sv.axis = .vertical
        sv.spacing = 16 // 디자이너님께 SE모델 보여드리고 컨펌 받기
        sv.alignment = .center
        sv.distribution = .fill
        return sv
    }()
    
    // MARK: - Init
    init(tabBarIcon: UIImage, tabBarLabel: String, isSelected: Bool, size: Int) {
        self.size = size
        super.init(frame: .zero)
        
        self.tabBarIconImageView.image = tabBarIcon
        self.tabBarLabel.text = tabBarLabel
        
        self.tabBarIconColor = isSelected ? BudgetBuddiesAsset.AppColor.coreYellow.color : BudgetBuddiesAsset.AppColor.barGray.color
        
        self.tabBarIconImageView.tintColor = tabBarIconColor
        self.tabBarLabel.textColor = tabBarIconColor
        
        self.isUserInteractionEnabled = false
        
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.addSubviews(tabBarStackView)
        
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
}
