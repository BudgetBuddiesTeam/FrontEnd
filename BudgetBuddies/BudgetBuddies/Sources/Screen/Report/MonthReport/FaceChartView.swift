//
//  FaceChartView.swift
//  BudgetBuddies
//
//  Created by 이승진 on 7/24/24.
//

import UIKit
import SnapKit
import DGCharts

final class FaceChartView: UIView {
    let monthLabel = {
        let label = UILabel()
        label.text = "6월"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    let beforeButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "arrowtriangle.left.fill"), for: .normal)
        button.tintColor = .systemGray6
        return button
    }()
    
    let afterButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
        button.tintColor = .systemGray6
        return button
    }()
    
    let monthStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 2
        sv.distribution = .fillEqually
        return sv
    }()
    
    let pieChartView = PieChartView()
    
    let centerImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "BasicFace")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let commentView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8156862745, blue: 0.1137254902, alpha: 1)
        view.layer.cornerRadius = 14
        view.layer.borderColor = #colorLiteral(red: 1, green: 0.8156862745, blue: 0.1137254902, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    let commentLabel = {
        let label = UILabel()
        label.text = "이번달에는 유흥에 1만원 이상 쓰면 안돼요!"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        return label
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
        
        _ = [beforeButton, monthLabel, afterButton].map {
            self.monthStackView.addArrangedSubview($0)
        }
        
        [monthStackView, pieChartView, centerImageView, commentView, commentLabel].forEach {
            self.addSubview($0)
        }
        
        commentView.addSubview(commentLabel)
    }
    
    private func setConst() {
        beforeButton.snp.makeConstraints {
            $0.width.height.equalTo(14)
        }
        
        afterButton.snp.makeConstraints {
            $0.width.height.equalTo(14)
        }
        
        monthStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(140)
            $0.trailing.equalToSuperview().offset(-140)
        }
        
        pieChartView.snp.makeConstraints {
            $0.top.equalTo(monthStackView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(pieChartView.snp.width).multipliedBy(0.5)
        }
        
        centerImageView.snp.makeConstraints {
            $0.center.equalTo(pieChartView)
            $0.width.height.equalTo(pieChartView.snp.width).multipliedBy(0.4)
        }
        
        commentView.snp.makeConstraints {
            $0.top.equalTo(pieChartView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
        }
        
        commentLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
    
    func setupChart(entries: [PieChartDataEntry]) {
        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.colors = [UIColor.systemYellow, UIColor.systemGray6]
        dataSet.drawValuesEnabled = false
        dataSet.sliceSpace = 2
        dataSet.selectionShift = 5 // 슬라이스의 두께를 줄임
        
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

