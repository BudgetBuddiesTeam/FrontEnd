//
//  TextAndRightChevronButton.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/6/24.
//

import SnapKit
import UIKit

class TextAndRightChevronButton: UIButton {
  // MARK: - UI Components

  // 텍스트 레이블
  public let textLabel: UILabel = {
    let label = UILabel()
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    label.font = BudgetBuddiesFontFamily.Pretendard.regular.font(size: 14)
    return label
  }()

  // 오른쪽 쉐브론 이미지뷰
  private let rightChevronImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "chevron.right")
    imageView.tintColor = BudgetBuddiesAsset.AppColor.subGray.color
    return imageView
  }()

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  private func setLayout() {
    self.backgroundColor = .clear

    // Add Subviews
    self.addSubviews(
      textLabel,
      rightChevronImageView
    )

    // Make UI Components Contraint
    // 텍스트 레이블
    textLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().inset(5)
    }

    // 오른쪽 쉐브론 이미지뷰
    rightChevronImageView.snp.makeConstraints { make in
      make.width.equalTo(10)
      make.height.equalTo(13)
      make.centerY.equalToSuperview()
      make.trailing.equalToSuperview().inset(5)
    }
  }
}
