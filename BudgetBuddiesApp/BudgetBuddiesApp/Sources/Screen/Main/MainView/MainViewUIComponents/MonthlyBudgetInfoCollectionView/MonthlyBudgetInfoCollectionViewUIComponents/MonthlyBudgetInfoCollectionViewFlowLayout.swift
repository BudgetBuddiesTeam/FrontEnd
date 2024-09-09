//
//  MonthlyBudgetInfoCollectionViewFlowLayout.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/10/24.
//

import Foundation
import UIKit

class MonthlyBudgetInfoCollectionViewFlowLayout: UICollectionViewFlowLayout {
  // MARK: - Intializer

  override init() {
    super.init()

    self.setCollectionViewFlowLayoutSetting()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  private func setCollectionViewFlowLayoutSetting() {
    self.scrollDirection = .horizontal
    self.itemSize = CGSize(width: 127, height: 162)
    self.minimumInteritemSpacing = 12
    self.headerReferenceSize = CGSize(width: 24, height: 162)
    self.footerReferenceSize = CGSize(width: 24, height: 162)
  }
}
