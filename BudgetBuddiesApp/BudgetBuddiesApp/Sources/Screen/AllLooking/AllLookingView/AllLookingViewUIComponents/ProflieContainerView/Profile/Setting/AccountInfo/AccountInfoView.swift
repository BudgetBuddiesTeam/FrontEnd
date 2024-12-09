//
//  AccountInfoView.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 12/2/24.
//

import UIKit
import SnapKit

class AccountInfoView: BaseView {
    // MARK: - UI Components
    
    /// 전화번호 or 이메일 타이틀 라벨
    public let infoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "infoTitleLabel"
        label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
        label.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 16)
        return label
    }()
    
    /// 전화번호 or 이메일 라벨
    public let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "infoLabel"
        label.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
        label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 14)
        return label
    }()
    
    /// 변경하기 텍스트 라벨
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.text = "변경하기"
        label.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
        label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 14)
        return label
    }()
    
    /// 오른쪽 쉐브론 이미지
    private let chevronRightImage: UIImageView = {
      let imageView = UIImageView()
      imageView.image = UIImage(systemName: "chevron.right")
      imageView.tintColor = BudgetBuddiesAppAsset.AppColor.subGray.color
      imageView.snp.makeConstraints {
        $0.width.equalTo(10)
        $0.height.equalTo(19)
      }
      return imageView
    }()

    override func initLayout() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        
        [infoTitleLabel, infoLabel, changeLabel, chevronRightImage].forEach {
            self.addSubview($0)
        }
        
        infoTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(infoTitleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
        }
        
        chevronRightImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-14)
        }
        
        changeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(chevronRightImage.snp.leading).offset(-4)
        }
    }
}
