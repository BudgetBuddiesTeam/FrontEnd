//
//  ProfileTopView.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 11/25/24.
//

import UIKit
import SnapKit

class ProfileTopView: BaseView {
    
    // MARK: - UI Components
    
    /// 이름 라벨
    public lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "김헤인"
        label.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 18)
        label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
        return label
    }()
    
    /// 태그 라벨
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.text = "@1234567"
        label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 12)
        label.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
        return label
    }()
    
    /// 성별 라벨
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "여성"
        label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 14)
        label.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
        label.textAlignment = .center
        label.backgroundColor = BudgetBuddiesAppAsset.AppColor.strokeGray1.color
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.layer.borderColor = BudgetBuddiesAppAsset.AppColor.strokeGray1.color.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    /// 나이 라벨
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "23세"
        label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 14)
        label.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
        label.textAlignment = .center
        label.backgroundColor = BudgetBuddiesAppAsset.AppColor.strokeGray1.color
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.layer.borderColor = BudgetBuddiesAppAsset.AppColor.strokeGray1.color.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    /// 프로필 수정 버튼
    private let profileEditButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("프로필 수정", for: .normal)
        btn.setTitleColor(BudgetBuddiesAppAsset.AppColor.subGray.color, for: .normal)
        btn.titleLabel?.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 14)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        btn.layer.borderColor = BudgetBuddiesAppAsset.AppColor.barGray.color.cgColor
        return btn
    }()
    
    override func initUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        
        [nameLabel, tagLabel, profileEditButton, genderLabel, ageLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func initLayout() {
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        tagLabel.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(8)
        }
        
        profileEditButton.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.top)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.equalTo(87)
            $0.height.equalTo(33)
        }
        
        genderLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(45)
            $0.height.equalTo(25)
        }
        
        ageLabel.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.top)
            $0.leading.equalTo(genderLabel.snp.trailing).offset(8)
            $0.width.equalTo(45)
            $0.height.equalTo(25)
        }
    }
}
