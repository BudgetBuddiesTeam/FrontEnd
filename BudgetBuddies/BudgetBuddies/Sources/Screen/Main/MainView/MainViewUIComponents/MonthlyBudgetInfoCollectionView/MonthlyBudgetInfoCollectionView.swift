//
//  MonthlyBudgetInfoCollectionView.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/6/24.
//

import Foundation
import UIKit

class MonthlyBudgetInfoCollectionView: UICollectionView {

  // MARK: - Intializer

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)

    registerCell()
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  private func registerCell() {
    register(
      MonthlyBudgetInfoCollectionViewCell.self,
      forCellWithReuseIdentifier: MonthlyBudgetInfoCollectionViewCell.reuseIdentifier)
  }

  private func setLayout() {
    self.backgroundColor = .clear
    self.showsHorizontalScrollIndicator = false
    self.showsVerticalScrollIndicator = false
  }
}
