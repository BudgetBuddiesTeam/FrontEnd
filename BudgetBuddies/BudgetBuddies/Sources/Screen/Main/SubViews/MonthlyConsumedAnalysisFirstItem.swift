//
//  ConsumedAnalysisFirstItem.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/9/24.
//

import UIKit
import SnapKit

class MonthlyConsumedAnalysisFirstItem: UIView {
  
  // MARK: - UI Componenets
  
  private let firstLineTextLabel: UILabel = {
    let label = UILabel()
    label.text = "혜인님 또래는"
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 16)
    return label
  }()
  
  private let secondLineTextLabel: UILabel = {
     let label = UILabel()
    label.text = "패션에 가장 큰 목표를 세웠어요"
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 16)
    return label
  }()
  
  private let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = BudgetBuddiesAsset.AppImage.MainViewImage.graphIcon.image
    return imageView
  }()
  
  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Methods
  
  private func setLayout() { 
    backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    layer.cornerRadius = 15
    
    self.snp.makeConstraints { make in
      make.height.equalTo(88)
    }
    
    addSubviews(firstLineTextLabel,
                secondLineTextLabel,
                iconImageView)
    
    firstLineTextLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.top.equalToSuperview().inset(20)
    }
    
    secondLineTextLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.bottom.equalToSuperview().inset(20)
    }
    
    iconImageView.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(31)
      make.centerY.equalToSuperview()
    }
  }

}
