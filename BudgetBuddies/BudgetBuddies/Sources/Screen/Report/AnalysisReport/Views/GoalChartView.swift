//
//  GoalChartView.swift
//  BudgetBuddies
//
//  Created by 이승진 on 7/24/24.
//

import DGCharts
import SnapKit
import UIKit

final class GoalChartView: UIView {
  let planLabel: UILabel = {
    let label = UILabel()
    label.text = "패션에 가장 큰 \n계획을 세웠어요"
      label.setCharacterSpacing(-0.55)
      label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 22)
    label.numberOfLines = 0
    return label
  }()

  let dateLabel: UILabel = {
    let label = UILabel()
      label.text = " "
      label.setCharacterSpacing(-0.3)
      label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    label.font = .systemFont(ofSize: 12, weight: .regular)

    // 현재 날짜 및 시간 가져오기
    let currentDate = Date()

    // 날짜 포맷터 생성
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR")  // 한국식 날짜 표현을 위해 로케일 설정
    dateFormatter.dateFormat = "yy년 M월 (M/dd HH:mm)"  // 원하는 형식

    // 현재 날짜를 포맷된 문자열로 변환
    let dateString = dateFormatter.string(from: currentDate)

    // 라벨에 텍스트 설정
    label.text = dateString
    return label
  }()

    let pieChartBackImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "pieChartBackImage")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
  let pieChartView = PieChartView()

  let firstLabel = {
    let label = UILabel()
    label.text = "패션"
      label.setCharacterSpacing(-0.45)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    label.textAlignment = .center
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 18)
    return label
  }()

  let firstPrice = {
    let label = UILabel()
    label.text = "120,000원"
      label.setCharacterSpacing(-0.35)
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    label.textAlignment = .center
    label.font = BudgetBuddiesFontFamily.Pretendard.regular.font(size: 14)
    return label
  }()

  let legendStackView: UIStackView = {
    let sv = UIStackView()
    sv.axis = .vertical
    sv.spacing = 36
      sv.alignment = .leading
      sv.distribution = .fill
    return sv
  }()

  let stackView: UIStackView = {
    let sv = UIStackView()
    sv.axis = .vertical
    sv.spacing = 36
    sv.distribution = .fillEqually
      
    return sv
  }()

    // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setConst()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  private func setup() {
    [planLabel, dateLabel, pieChartBackImageView, firstLabel, firstPrice, legendStackView, stackView].forEach
    {
      self.addSubview($0)
    }
      
      pieChartBackImageView.addSubviews(pieChartView)
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
      
      pieChartBackImageView.snp.makeConstraints { make in
          make.top.equalTo(dateLabel.snp.bottom).offset(30)
          make.leading.equalToSuperview().offset(20)
          make.width.equalTo(215)
          make.height.equalTo(pieChartView.snp.width)
      }

      pieChartView.snp.makeConstraints { make in
          make.center.equalToSuperview()
          make.height.width.equalTo(200)
      }

    firstLabel.snp.makeConstraints {
      $0.centerX.equalTo(pieChartView)
      $0.centerY.equalTo(pieChartView).offset(-10)
    }

    firstPrice.snp.makeConstraints {
      $0.top.equalTo(firstLabel.snp.bottom).offset(4)
      $0.centerX.equalTo(firstLabel)
    }

    legendStackView.snp.makeConstraints {
      $0.centerY.equalTo(pieChartView)
        $0.trailing.equalToSuperview().inset(10)
        $0.width.equalTo(70)
    }

    stackView.snp.makeConstraints {
      $0.top.equalTo(pieChartView.snp.bottom).offset(50)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalToSuperview().offset(-30)
    }
  }

  func setupChart(entries: [PieChartDataEntry]) {
    let dataSet = PieChartDataSet(entries: entries, label: "소비습관")
    dataSet.colors = [
        BudgetBuddiesAsset.AppColor.coreBlue.color,
        BudgetBuddiesAsset.AppColor.sky3.color,
        BudgetBuddiesAsset.AppColor.orange2.color,
        BudgetBuddiesAsset.AppColor.coreYellow.color
    ]
    dataSet.drawValuesEnabled = false
    dataSet.sliceSpace = 2
    dataSet.selectionShift = 5

    let data = PieChartData(dataSet: dataSet)
    pieChartView.data = data

    pieChartView.usePercentValuesEnabled = false
    pieChartView.drawHoleEnabled = true
    pieChartView.holeRadiusPercent = 0.75
    pieChartView.transparentCircleRadiusPercent = 0.76
    pieChartView.chartDescription.enabled = false
    pieChartView.legend.enabled = false
    pieChartView.notifyDataSetChanged()
    pieChartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
  }

  func updateFirstGoal(category: String, value: Int) {
    firstLabel.text = category
    firstPrice.text = "\(value.formatted())원"  // 가격 형식으로 변환
    planLabel.text = "\(category)에 가장 큰 \n계획을 세웠어요"
  }

  func setChartData(data: [(rank: String, category: String, value: Int, color: UIColor)]) {
    stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    legendStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

    for item in data {
      let itemView = createChartItemView(
        rank: item.rank, category: item.category, value: item.value, color: item.color)
      stackView.addArrangedSubview(itemView)

      let legendItemView = createLegendItemView(category: item.category, color: item.color)
      legendStackView.addArrangedSubview(legendItemView)
    }
  }

  private func createChartItemView(rank: String, category: String, value: Int, color: UIColor)
    -> UIView
  {
    let containerView = UIView()

    let rankLabel: UILabel = {
      let label = UILabel()
      label.text = rank
      label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
      label.textColor = BudgetBuddiesAsset.AppColor.logoLine2.color
      label.backgroundColor = BudgetBuddiesAsset.AppColor.lemon2.color
      label.textAlignment = .center
      label.layer.cornerRadius = 8
      label.layer.borderWidth = 1
      label.layer.borderColor = BudgetBuddiesAsset.AppColor.lemon.color.cgColor
      label.clipsToBounds = true
      return label
    }()

    let categoryLabel: UILabel = {
      let label = UILabel()
      label.text = category
      label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
      label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
      return label
    }()

    let valueLabel: UILabel = {
      let label = UILabel()
      label.text = "\(value.formatted())원"
        label.setCharacterSpacing(-0.35)
      label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
      label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
      return label
    }()

    [rankLabel, categoryLabel, valueLabel].forEach {
      containerView.addSubview($0)
    }

    rankLabel.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.centerY.equalToSuperview()
      $0.width.equalTo(32)
        $0.height.equalTo(20)
    }

    categoryLabel.snp.makeConstraints {
      $0.leading.equalTo(rankLabel.snp.trailing).offset(17)
      $0.centerY.equalToSuperview()
    }

    valueLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview()
      $0.centerY.equalToSuperview()
    }

    return containerView
  }

  private func createLegendItemView(category: String, color: UIColor) -> UIView {
    let containerView = UIView()

    let colorView: UIView = {
      let view = UIView()
      view.backgroundColor = color
      view.layer.cornerRadius = 4
      view.snp.makeConstraints { $0.size.equalTo(CGSize(width: 16, height: 16)) }
      return view
    }()

    let categoryLabel: UILabel = {
      let label = UILabel()
      label.text = category
      label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
      label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
      return label
    }()

    [colorView, categoryLabel].forEach {
      containerView.addSubview($0)
    }

    colorView.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.centerY.equalToSuperview()
    }

    categoryLabel.snp.makeConstraints {
      $0.leading.equalTo(colorView.snp.trailing).offset(8)
      $0.centerY.equalToSuperview()
    }

    return containerView
  }
}
