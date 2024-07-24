//
//  GoalChartView.swift
//  BudgetBuddies
//
//  Created by 이승진 on 7/24/24.
//

import UIKit
import SnapKit
import DGCharts

final class GoalChartView: UIView {
    let planLabel = {
        let label = UILabel()
        label.text = "패션에 가장 큰 \n계획을 세웠어요"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.text = "24년 8월 (8/25 11:30)"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    let pieChartView = PieChartView()
    
    let rankStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setConst()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        
        [planLabel, dateLabel, dateLabel, pieChartView, rankStackView].forEach {
            self.addSubview($0)
        }
        
        // Add dummy data for ranks
        for i in 1...4 {
            let label = UILabel()
            label.text = "\(i)위: 120,000원"
            label.font = .systemFont(ofSize: 16, weight: .regular)
            rankStackView.addArrangedSubview(label)
        }
    }
    
    private func setConst() {
        planLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(planLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(20)
        }
        
        pieChartView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(pieChartView.snp.width).multipliedBy(0.5)
        }
    }
    
    func setupChart(entries: [PieChartDataEntry]) {
        let dataSet = PieChartDataSet(entries: entries, label: "소비습관")
        dataSet.colors = [UIColor.systemBlue, UIColor.systemYellow, UIColor.systemOrange, UIColor.systemCyan]
        dataSet.drawValuesEnabled = false
        dataSet.sliceSpace = 2
        dataSet.selectionShift = 5 // 슬라이스의 두께를 줄임
        
        let entries = [
            PieChartDataEntry(value: 40, label: "패션"),
            PieChartDataEntry(value: 30, label: "쇼핑"),
            PieChartDataEntry(value: 20, label: "식비"),
            PieChartDataEntry(value: 10, label: "카페")
        ]
        
        let data = PieChartData(dataSet: dataSet)
        pieChartView.data = data
        
        pieChartView.usePercentValuesEnabled = false
        pieChartView.drawHoleEnabled = true
        pieChartView.holeRadiusPercent = 0.75 // 구멍 크기를 키우기
        pieChartView.transparentCircleRadiusPercent = 0.76
        pieChartView.chartDescription.enabled = false
        pieChartView.legend.enabled = false
        pieChartView.notifyDataSetChanged()
        pieChartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack) // 애니메이션을 추가
    }
}


