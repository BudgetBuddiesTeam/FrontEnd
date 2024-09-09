//
//  ExtendedLaunchScreenView.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/23/24.
//

import SnapKit
import UIKit

class ExtendedLaunchScreenView: UIView {
  // MARK: - Properties

  private let budgetBuddiesLogo: UIImageView = {
    let imageView = UIImageView()
    imageView.image = BudgetBuddiesAppAsset.AppImage.Logo.logoImage.image
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
    self.backgroundColor = BudgetBuddiesAppAsset.AppColor.coreYellow.color

    self.addSubview(budgetBuddiesLogo)
    budgetBuddiesLogo.snp.makeConstraints { make in
      make.width.equalTo(116)
      make.height.equalTo(108)
      make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(261)
      make.centerX.equalToSuperview()
    }
  }
}
