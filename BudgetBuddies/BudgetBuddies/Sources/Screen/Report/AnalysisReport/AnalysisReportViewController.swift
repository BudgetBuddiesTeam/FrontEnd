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

  let rangeEditButton = {
    let button = UIButton(type: .custom)
    button.setTitle("범위변경", for: .normal)
    button.setTitleColor(.orange, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    button.backgroundColor = .systemOrange
    button.layer.cornerRadius = 10
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.systemOrange.cgColor
    button.backgroundColor = .white
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
    view.totalButton.addTarget(self, action: #selector(goalTotalButtonTapped), for: .touchUpInside)
    return view
  }()

  let barChartView = BarChartView()

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViews()
    setupConstraints()
    //        setupPieChart()
    setupBarChart()
  }

  func setupViews() {
    view.backgroundColor = .white
    navigationItem.title = "또래 비교 분석 레포트"

    view.addSubview(scrollView)
    scrollView.addSubview(contentView)

    [
      titleLabel, ageGenderLabel, rangeEditButton, ageView, goalReportView, goalChartView,
      comsumeReportView, barChartView,
    ].forEach {
      contentView.addSubview($0)
    }

    [ageGenderLabel, rangeEditButton].forEach {
      ageView.addSubview($0)
    }
  }

  func setupConstraints() {
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
      $0.top.equalTo(titleLabel.snp.bottom).offset(8)
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
      $0.top.equalTo(ageView.snp.bottom).offset(8)
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
      $0.top.equalTo(goalChartView.snp.bottom).offset(30)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
    }

    barChartView.snp.makeConstraints { make in
      make.top.equalTo(comsumeReportView.snp.bottom).offset(16)
      make.left.equalTo(contentView).offset(16)
      make.right.equalTo(contentView).offset(-16)
      make.height.equalTo(200)
      make.bottom.equalTo(contentView)
    }
  }

  //    private func setupPieChart() {
  //        let entries = [
  //            PieChartDataEntry(value: 40, label: "패션"),
  //            PieChartDataEntry(value: 30, label: "쇼핑"),
  //            PieChartDataEntry(value: 20, label: "식비"),
  //            PieChartDataEntry(value: 10, label: "카페")
  //        ]
  //        let dataSet = PieChartDataSet(entries: entries, label: "소비 습관")
  //        dataSet.colors = ChartColorTemplates.material()
  //        let data = PieChartData(dataSet: dataSet)
  //        pieChartView.data = data
  //    }

  func setupBarChart() {
    let entries = [
      BarChartDataEntry(x: 1, y: 112),
      BarChartDataEntry(x: 2, y: 98),
      BarChartDataEntry(x: 3, y: 72),
    ]
    let dataSet = BarChartDataSet(entries: entries, label: "소비 항목")
    dataSet.colors = [UIColor.systemOrange]
    let data = BarChartData(dataSet: dataSet)
    barChartView.data = data
  }

  @objc func goalTotalButtonTapped(_ gesture: UITapGestureRecognizer) {
    if let naviController = self.navigationController {
      let AnalysisReportVC = AnalysisReportViewController()
      naviController.pushViewController(AnalysisReportVC, animated: true)
    }
  }
}
