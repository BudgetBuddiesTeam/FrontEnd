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
//    func didUpdateAgeAndGender(ageRange: (Int, Int), gender: String) {
//        // 전달받은 나이와 성별로 UI 업데이트
//                ageGenderLabel.text = "\(ageRange.0)~\(ageRange.1)세 \(gender == "male" ? "남성" : "여성")"
//                
//                // 새로운 나이와 성별로 데이터 로드 (예: 네트워크 호출)
//                loadTop4()
//                loadTop3()
//    }
    
    // MARK: - Property
    var services = Services()
    var getConsumeGoalResponse: GetConsumeGoalResponse? = nil
    var getTopGoalResponse: GetTopGoalResponse? = nil
    var getTopGoalsResponse: GetTopGoalsResponse? = nil
    var getTopConsumptionResponse: GetTopConsumptionResponse? = nil
    var getTopConsumptionsResponse: GetTopConsumptionsResponse? = nil
    var getTopUserResponse: GetTopUserResponse? = nil
    var consumePeerInfoResponse: ConsumePeerInfoResponse? = nil

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
      setNavi()
      
      loadPeerInfo()

    setupViews()
    setupConstraints()
    setupPieChart()
  }

  // MARK: - Methods

  private func setupViews() {
    view.backgroundColor = .white

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
    
    private func setNavi() {
        navigationItem.title = "또래 비교 분석 레포트"
          let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)  // title 부분 수정
          backBarButtonItem.tintColor = .black
          self.navigationItem.backBarButtonItem = backBarButtonItem
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

    // 차트 데이터 세팅
  
    private func setupChart(_ topGoals: [GetTopGoalsResponse.GetTopGoalsResult]) {
        // 차트에 사용할 색상 배열
        let colors: [UIColor] = [
            UIColor.systemBlue,
            UIColor.systemYellow,
            UIColor.systemOrange,
            UIColor.systemCyan
        ]
        
        // 최대 4개의 topGoals 데이터만 사용
        var chartData: [(rank: String, category: String, value: Int, color: UIColor)] = []
        
        for (index, goal) in topGoals.prefix(4).enumerated() {
            let rank = "\(index + 1)위"
            let category = goal.categoryName ?? "Unknown"
            let value = goal.goalAmount ?? 0
            let color = colors[index % colors.count] // 색상 배열 내에서 순환
            
            chartData.append((rank: rank, category: category, value: value, color: color))
        }
        
        // 차트 데이터를 설정
        goalChartView.setChartData(data: chartData)
        
        if let firstGoal = chartData.first {
            goalChartView.updateFirstGoal(category: firstGoal.category, value: firstGoal.value)
        }
    }

  private func setupBarChart(_ topConsumptions: [GetTopConsumptionsResponse.GetTopConsumptionsResult]) {
      // 차트에 사용할 색상 배열
          let colors: [UIColor] = [
              BudgetBuddiesAsset.AppColor.logoLine2.color,
              BudgetBuddiesAsset.AppColor.coreYellow.color,
              BudgetBuddiesAsset.AppColor.face.color
          ]
          
          // 최대 3개의 topConsumptions 데이터만 사용
          var chartData: [(rank: String, category: String, value: Int, color: UIColor)] = []
          
          for (index, consumption) in topConsumptions.prefix(3).enumerated() {
              let rank = "\(index + 1)위"
              let category = consumption.categoryName ?? "Unknown"
              let value = consumption.consumptionCount ?? 0
              let color = colors[index % colors.count] // 색상 배열 내에서 순환
              
              chartData.append((rank: rank, category: category, value: value, color: color))
          }
          
          // 차트 데이터를 설정
          reportBarChartView.setChartData(data: chartData)
      
      if let firstSpend = chartData.first {
          reportBarChartView.updateFirstSpend(category: firstSpend.category)
      }
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

// MARK: - 네트워킹

extension AnalysisReportViewController {
    func loadPeerInfo() {
        services.consumeGoalService.getPeerInfo(userId: 1, peerAgeStart: 23, peerAgeEnd: 25, peerGender: "male") { result in
            switch result {
            case .success(let response):
                self.consumePeerInfoResponse = response
                dump(response)
                
                // 피어 정보가 존재하는지 확인
                if let peerInfo = response.result {
                    if let peerAgeStart = peerInfo.peerAgeStart,
                       let peerAgeEnd = peerInfo.peerAgeEnd,
                       let peerGender = peerInfo.peerGender {
                        
                        // 동적으로 피어 정보 기반으로 데이터 로드
                        self.loadTop4(peerAgeStart: peerAgeStart, peerAgeEnd: peerAgeEnd, peerGender: peerGender)
                        self.loadTop3(peerAgeStart: peerAgeStart, peerAgeEnd: peerAgeEnd, peerGender: peerGender)
                    } else {
                        print("Peer info is incomplete")
                    }
                } else {
                    print("No peer info available")
                }
                
            case.failure(let error):
                print("Failed to load peer info: \(error)")
            }
        }
    }
    
    // Top 4 데이터를 로드하고 차트에 반영하는 메소드
    func loadTop4(peerAgeStart: Int, peerAgeEnd: Int, peerGender: String) {
        services.consumeGoalService.getTopGoals(userId: 1, peerAgeStart: peerAgeStart, peerAgeEnd: peerAgeEnd, peerGender: peerGender) { result in
            switch result {
            case .success(let response):
                self.getTopGoalsResponse = response
                dump(response)
                
                // result 배열이 존재하는지 확인하고, 데이터 매핑 후 차트에 반영
                if let topGoals = response.result {
                    self.setupChart(topGoals)
                } else {
                    print("No result data available")
                }
                
            case .failure(let error):
                print("Failed to load Top goals: \(error)")
            }
        }
    }
    
    // Top 3 데이터 로드하고 차트에 반영하는 메소드
    func loadTop3(peerAgeStart: Int, peerAgeEnd: Int, peerGender: String) {
        services.consumeGoalService.getTopConsumptions(userId: 1, peerAgeStart: peerAgeStart, peerAgeEnd: peerAgeEnd, peerGender: peerGender) { result in
            switch result {
            case .success(let response):
                self.getTopConsumptionsResponse = response
                dump(response)
                
                // 성공적으로 데이터를 받으면 차트 업데이트
                if let topConsumptions = response.result {
                    self.setupBarChart(topConsumptions)
                }
                
            case .failure(let error):
                print("Failed to load Top goals: \(error)")
            }
        }
    }
}
