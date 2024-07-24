//
//  MonthReportViewController.swift
//  BudgetBuddies
//
//  Created by 이승진 on 7/24/24.
//

import UIKit
import SnapKit
import DGCharts

final class MonthReportViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    // 총 목표액과 총 소비액 변수
    let totalGoalAmount: Double = 800000
    let totalSpentAmount: Double = 612189
    
    let topView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8156862745, blue: 0.1137254902, alpha: 1)
        view.layer.cornerRadius = 20
        return view
    }()
    
    let faceChartView = {
        let view = FaceChartView()
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
    
    let totalSpendLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    let remainingAmountLabel = UILabel()
    
    
    let spendingGoalsLabel = UILabel()
    let categoriesStackView = UIStackView()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "이번달 리포트"

        setup()
        setConst()
        setupChart()
      
    }
    
    private func setup() {
        self.view.sendSubviewToBack(topView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [topView, faceChartView].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setConst() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        topView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.leading.trailing.equalTo(contentView)
            $0.height.equalTo(280)
        }
        
        faceChartView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(20)
            $0.leading.equalTo(contentView).offset(16)
            $0.trailing.equalTo(contentView).offset(-16)
            $0.height.equalTo(350)
        }
    }
    
    private func setupChart() {
        let spentEntry = PieChartDataEntry(value: totalSpentAmount)
        let remainingEntry = PieChartDataEntry(value: totalGoalAmount - totalSpentAmount)
        
        faceChartView.setupChart(entries: [spentEntry, remainingEntry])
    }
//
//    // 금액을 포맷팅하는 헬퍼 함수
//    func formatCurrency(_ amount: Double) -> String {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
//    }
    

}

