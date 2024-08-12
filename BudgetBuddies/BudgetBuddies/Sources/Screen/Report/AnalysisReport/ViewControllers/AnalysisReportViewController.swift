//
//  AnalysisReportViewController.swift
//  BudgetBuddies
//
//  Created by 이승진 on 7/24/24.
//

import Charts
import DGCharts
import SnapKit
import UIKit

final class AnalysisReportViewController: UIViewController {

  let scrollView = UIScrollView()
  let contentView = UIView()

  // MARK: - UI Components

  let titleLabel = {
    let label = UILabel()
    label.text = "혜인님 또래는 \n어떻게 소비했을까요?"
    label.textColor = .black
    label.font = .systemFont(ofSize: 22, weight: .bold)
    label.numberOfLines = 0
    return label
  }()

  let ageGenderLabel = {
    let label = UILabel()
    label.text = "23~26세 여성"
    label.textColor = .black
    label.font = .systemFont(ofSize: 14, weight: .medium)
    return label
  }()

  lazy var rangeEditButton = {
    let button = UIButton(type: .custom)
    button.setTitle("범위변경", for: .normal)
    button.setTitleColor(.orange, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    button.backgroundColor = BudgetBuddiesAsset.AppColor.face.color
    button.layer.cornerRadius = 10
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.systemOrange.cgColor
    button.addTarget(self, action: #selector(ageEditButtonTapped), for: .touchUpInside)
    return button
  }()

  let ageView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 16
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.white.cgColor
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.3
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowRadius = 4
    return view
  }()

  lazy var goalReportView = {
    let view = TopStackView()
    view.titleLabel.text = "소비목표 레포트"
    view.totalButton.addTarget(self, action: #selector(goalTotalButtonTapped), for: .touchUpInside)
    return view
  }()

  let goalChartView = {
    let view = GoalChartView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 20
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.white.cgColor
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.3
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowRadius = 4
    return view
  }()

  lazy var comsumeReportView = {
    let view = TopStackView()
    view.titleLabel.text = "소비 레포트"
    view.totalButton.addTarget(
      self, action: #selector(consumeTotalButtonTapped), for: .touchUpInside)
    return view
  }()

  let reportBarChartView = {
    let view = ReportBarChartView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 20
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.white.cgColor
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.3
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowRadius = 4
    return view
  }()

  // MARK: - View Life Cycle

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.navigationBar.isHidden = false
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViews()
    setupConstraints()
    setupChart()
    setupPieChart()
    setupBarChart()
  }

  // MARK: - Methods

  private func setupViews() {
    view.backgroundColor = .white
    navigationItem.title = "또래 비교 분석 레포트"

    view.addSubview(scrollView)
    scrollView.addSubview(contentView)

    [
      titleLabel, ageGenderLabel, rangeEditButton, ageView, goalReportView, goalChartView,
      comsumeReportView, reportBarChartView,
    ].forEach {
      contentView.addSubview($0)
    }

    [ageGenderLabel, rangeEditButton].forEach {
      ageView.addSubview($0)
    }
  }

  private func setupConstraints() {
    scrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    contentView.snp.makeConstraints {
      $0.width.equalToSuperview()
      $0.centerX.top.bottom.equalToSuperview()
    }

    titleLabel.snp.makeConstraints {
      $0.top.equalTo(contentView).offset(16)
      $0.left.equalTo(contentView).offset(16)
      $0.right.equalTo(contentView).offset(-16)
    }

    ageView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(16)
      $0.leading.equalTo(contentView).offset(16)
      $0.trailing.equalTo(contentView).offset(-16)
      $0.height.equalTo(60)
    }

    ageGenderLabel.snp.makeConstraints {
      $0.leading.equalTo(ageView).offset(20)
      $0.centerY.equalTo(ageView)
    }

    rangeEditButton.snp.makeConstraints {
      $0.trailing.equalTo(ageView).offset(-20)
      $0.centerY.equalTo(ageView)
      $0.width.equalTo(66)
      $0.height.equalTo(24)
    }

    goalReportView.snp.makeConstraints {
      $0.top.equalTo(ageView.snp.bottom).offset(24)
      $0.leading.equalTo(contentView).offset(16)
      $0.trailing.equalTo(contentView).offset(-16)
      $0.height.equalTo(40)
    }

    goalChartView.snp.makeConstraints {
      $0.top.equalTo(goalReportView.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
    }

    comsumeReportView.snp.makeConstraints {
      $0.top.equalTo(goalChartView.snp.bottom).offset(24)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.height.equalTo(40)
    }

    reportBarChartView.snp.makeConstraints {
      $0.top.equalTo(comsumeReportView.snp.bottom).offset(10)
      $0.leading.equalTo(contentView).offset(16)
      $0.trailing.equalTo(contentView).offset(-16)
      $0.bottom.equalTo(contentView).offset(-16)
      $0.height.equalTo(300)
    }
  }

  private func setupPieChart() {
    let entries = [
      PieChartDataEntry(value: 40),
      PieChartDataEntry(value: 30),
      PieChartDataEntry(value: 20),
      PieChartDataEntry(value: 10),
    ]
    goalChartView.setupChart(entries: entries)
  }

  private func setupChart() {
    let chartData = [
      (rank: "1위", category: "패션", value: 120000, color: UIColor.systemBlue),
      (rank: "2위", category: "쇼핑", value: 100000, color: UIColor.systemYellow),
      (rank: "3위", category: "식비", value: 80000, color: UIColor.systemOrange),
      (rank: "4위", category: "카페", value: 60000, color: UIColor.systemCyan),
    ]
    goalChartView.setChartData(data: chartData)
  }

  //    private func setupChart() {
  //        let data = [
  //            (rank: "1위", category: "패션", value: 112, color: BudgetBuddiesAsset.AppColor.logoLine2.color),
  //            (rank: "2위", category: "유흥", value: 98, color: BudgetBuddiesAsset.AppColor.coreYellow.color),
  //            (rank: "3위", category: "식비", value: 72, color: BudgetBuddiesAsset.AppColor.face.color),
  //            (rank: "4위", category: "카페", value: 72, color: BudgetBuddiesAsset.AppColor.face.color)
  //        ]
  //        goalChartView.setChartData(data: data)
  //    }

  private func setupBarChart() {
    let data = [
      (rank: "1위", category: "패션", value: 112, color: BudgetBuddiesAsset.AppColor.logoLine2.color),
      (rank: "2위", category: "유흥", value: 98, color: BudgetBuddiesAsset.AppColor.coreYellow.color),
      (rank: "3위", category: "문화", value: 72, color: BudgetBuddiesAsset.AppColor.face.color),
    ]
    reportBarChartView.setChartData(data: data)
  }

  @objc func ageEditButtonTapped() {
    if let naviController = self.navigationController {
      let AnalysisReportVC = AgeEditViewController()
      naviController.pushViewController(AnalysisReportVC, animated: true)
    }
  }

  @objc func goalTotalButtonTapped(_ gesture: UITapGestureRecognizer) {
    if let naviController = self.navigationController {
      let goalReportVC = GoalReportViewController()
      naviController.pushViewController(goalReportVC, animated: true)
    }
  }

  @objc func consumeTotalButtonTapped() {
    if let naviController = self.navigationController {
      let consumeReportVC = ConsumeReportViewController()
      naviController.pushViewController(consumeReportVC, animated: true)
    }
  }
}
