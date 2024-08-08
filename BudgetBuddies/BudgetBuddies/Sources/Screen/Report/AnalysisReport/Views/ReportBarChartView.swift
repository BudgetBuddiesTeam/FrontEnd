//
//  ReportBarChartView.swift
//  BudgetBuddies
//
//  Created by 이승진 on 7/30/24.
//

import DGCharts
import SnapKit
import UIKit

final class ReportBarChartView: UIView {

  let titleLabel = {
    let label = UILabel()
    label.text = "패션에 가장 많이 \n소비했어요"
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

  let stackView = {
    let sv = UIStackView()
    sv.axis = .vertical
    sv.spacing = 4
    sv.distribution = .fillEqually
    return sv
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setConsts()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
    setConsts()
  }

  private func setup() {
    [titleLabel, dateLabel, stackView].forEach {
      addSubview($0)
    }
  }

  private func setConsts() {
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(20)
      $0.leading.equalToSuperview().offset(20)
    }

    dateLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(8)
      $0.leading.equalToSuperview().offset(20)
    }

    stackView.snp.makeConstraints {
      $0.top.equalTo(dateLabel.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalToSuperview().offset(-10)
    }
  }

  func setChartData(data: [(rank: String, category: String, value: Int, color: UIColor)]) {
    stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

    for item in data {
      let itemView = createChartItemView(
        rank: item.rank, category: item.category, value: Double(item.value), color: item.color)
      stackView.addArrangedSubview(itemView)
    }
  }

  private func createChartItemView(rank: String, category: String, value: Double, color: UIColor)
    -> UIView
  {
    let containerView = UIView()

    let rankLabel = {
      let label = UILabel()
      label.text = rank
      label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
      label.textColor = BudgetBuddiesAsset.AppColor.logoLine2.color
      label.backgroundColor = BudgetBuddiesAsset.AppColor.face.color
      label.textAlignment = .center
      label.layer.cornerRadius = 4
      label.layer.borderWidth = 1
      label.layer.borderColor = BudgetBuddiesAsset.AppColor.calendarYellow.color.cgColor
      return label
    }()

    let categoryLabel = {
      let label = UILabel()
      label.text = category
      label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
      label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
      return label
    }()

    let valueLabel = {
      let label = UILabel()
      label.text = "\(value)"
      label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
      label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
      return label
    }()

    let barView = {
      let view = UIView()
      view.backgroundColor = color
      view.layer.cornerRadius = 4
      return view
    }()

    [rankLabel, categoryLabel, valueLabel, barView].forEach {
      containerView.addSubview($0)
    }

    rankLabel.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.centerY.equalToSuperview()
      $0.width.equalTo(32)

    }

    categoryLabel.snp.makeConstraints {
      $0.leading.equalTo(rankLabel.snp.trailing).offset(8)
      $0.centerY.equalToSuperview()
    }

    valueLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview()
      $0.centerY.equalToSuperview()
    }

    barView.snp.makeConstraints {
      $0.leading.equalTo(categoryLabel.snp.trailing).offset(8)
      $0.centerY.equalToSuperview()
      $0.height.equalTo(24)
      $0.width.equalTo(value * 1.5)
    }

    return containerView
  }
}
