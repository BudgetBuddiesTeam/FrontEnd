//
//  DropDownMenuView.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/23/24.
//

import UIKit
import SnapKit

class DropDownMenuView: UIView {
    // MARK: - UI Components
    let regionLabel: UILabel = {
        let lb = UILabel()
        lb.text = "거주지역"
        lb.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
        lb.textColor = UIColor(red: 0.72, green: 0.72, blue: 0.72, alpha: 1)
        lb.setCharacterSpacing(-0.4)
        lb.textAlignment = .left
        return lb
    }()
    
    let chevronDownImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "chevronDownImage")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    

    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set View Name
    func changeTitleToSelectedRegion(_ region: String) {
        self.regionLabel.text = region
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.isUserInteractionEnabled = true
        
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
        self.layer.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1).cgColor // 에셋 등록 필요
        self.layer.masksToBounds = true
        
        self.addSubviews(regionLabel, chevronDownImageView)
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        regionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        chevronDownImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(21)
            make.centerY.equalToSuperview()
            make.height.equalTo(18)
            make.width.equalTo(13)
        }
    }
}
