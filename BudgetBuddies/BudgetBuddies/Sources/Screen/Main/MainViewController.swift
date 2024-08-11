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

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    setNavigationSetting()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setLayout()
    setUICollectionViewDelegate()
    setNavigationSetting()
    setButtonAction()
    setGestureAction()
  }

  // MARK: - Methods

  // Methods in ViewDidLoad method
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

  private func setNavigationSetting() {
    navigationController?.navigationBar.isHidden = true
  }

  private func setButtonAction() {
    // "목표 수정하기 >" 버튼
    mainView.summaryInfoContainerView.editGoalButtonContaier.addTarget(
      self, action: #selector(editGoalButtonContainerButtonTapped), for: .touchUpInside)

    // "N월 주머니 정보" 옆에 있는 "전체보기 >" 버튼
    mainView.monthlyBudgetInfoLookEntireButton.addTarget(
      self, action: #selector(budgetInfoLookEntireButtonContainerTapped), for: .touchUpInside)

    // "N월 소비 분석" 옆에 있는 "전체보기 >" 버튼
    mainView.monthlyConsumedAnalysisLookEntireButton.addTarget(
      self, action: #selector(comsumedAnalysisLookEntireButtonTapped), for: .touchUpInside)
  }

  private func setGestureAction() {
    // "N월 소비 분석" 항목 1
    let comsumedAnalysisFirstItemTapGestureRecognizer = UITapGestureRecognizer(
      target: self, action: #selector(comsumedAnalysisFirstItemTapped))
    mainView.comsumedAnalysisFirstItem.addGestureRecognizer(
      comsumedAnalysisFirstItemTapGestureRecognizer)

    // "N월 소비 분석" 항목 2
    let comsumedAnalysisSecondItemTapGestureRecgonizer = UITapGestureRecognizer(
      target: self, action: #selector(comsumedAnalysisSecondItemTapped))
    mainView.comsumedAnalysisSecondItem.addGestureRecognizer(
      comsumedAnalysisSecondItemTapGestureRecgonizer)

    mainView.comsumedAnalysisFirstItem.isUserInteractionEnabled = true
  }

  // Object C Methods
  // "목표 수정하기 >" 버튼
  @objc private func editGoalButtonContainerButtonTapped() {
    let goalEditViewController = GoalEditViewController()
    navigationController?.pushViewController(goalEditViewController, animated: true)
  }

  // "N월 주머니 정보" 옆에 있는 "전체보기 >" 버튼
  @objc private func budgetInfoLookEntireButtonContainerTapped() {
    let calendarViewController = CalendarViewController()
    navigationController?.pushViewController(calendarViewController, animated: true)
  }

  // "N월 소비 분석" 옆에 있는 "전체보기 >" 버튼
  @objc private func comsumedAnalysisLookEntireButtonTapped() {
    let analysisReportViewController = AnalysisReportViewController()
    navigationController?.pushViewController(analysisReportViewController, animated: true)
  }

  // "N월 소비 분석" 항목 1
  @objc private func comsumedAnalysisFirstItemTapped() {
    let goalReportViewController = GoalReportViewController()
    navigationController?.pushViewController(goalReportViewController, animated: true)
  }

  // "N월 소비 분석" 항목 2
  @objc private func comsumedAnalysisSecondItemTapped() {
    let comsumeReportViewController = ConsumeReportViewController()
    navigationController?.pushViewController(comsumeReportViewController, animated: true)
  }
}

// MARK: - MonthlyBudgetInfoCollectionView DataSource

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

// MARK: - MonthlyBudgetInfoCollectionView Delegate

extension MainViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    /*
     해야 할 일
     CollectionViewCell에 따른 InfoViewController로 navigationController로 연결되게 설계부탁드립니다.
     */
    let infoListViewController = InfoListViewController(infoType: .discount)
    navigationController?.pushViewController(infoListViewController, animated: true)
  }
}
