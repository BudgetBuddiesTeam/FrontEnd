//
//  MainViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/5/24.
//

import SnapKit
import UIKit

/*
 재보수 해야 할 작업
 1. ScrollView의 contentSize가 디바이스에 따라 다르게 적용되는 문제, 일관된 UX 제공을 할 수 없음
 */

final class MainViewController: UIViewController {

  // MARK: - Propertieas

  private let mainScrollView = UIScrollView()
  private let mainView = MainView()

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setLayout()
    setUICollectionViewDelegate()
  }

  // MARK: - Methods

  private func setLayout() {
    mainScrollView.backgroundColor = BudgetBuddiesAsset.AppColor.background.color
    mainScrollView.contentInsetAdjustmentBehavior = .never
    mainScrollView.bounces = false
    mainScrollView.showsVerticalScrollIndicator = false
    mainScrollView.showsHorizontalScrollIndicator = false

    view.addSubview(mainScrollView)
    mainScrollView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    mainScrollView.addSubview(mainView)
    mainView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.width.equalToSuperview()
    }
  }

  private func setUICollectionViewDelegate() {
    mainView.monthlyBudgetInfoCollectionView.delegate = self
    mainView.monthlyBudgetInfoCollectionView.dataSource = self
  }
}

extension MainViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
    -> Int
  {
    return 4
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell
  {
    let cell =
      collectionView.dequeueReusableCell(
        withReuseIdentifier: MonthlyBudgetInfoCollectionViewCell.reuseIdentifier, for: indexPath)
      as! MonthlyBudgetInfoCollectionViewCell

    return cell
  }
}

extension MainViewController: UICollectionViewDelegate {

}
