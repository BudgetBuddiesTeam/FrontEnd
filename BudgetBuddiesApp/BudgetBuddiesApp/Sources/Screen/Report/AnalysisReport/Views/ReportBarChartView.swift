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
    label.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 22)
    label.setCharacterSpacing(-0.55)
    label.numberOfLines = 0
    return label
  }()

  let dateLabel: UILabel = {
    let label = UILabel()
    label.text = " "
    label.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 12)

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
      $0.top.equalTo(dateLabel.snp.bottom).offset(25)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(125)
    }
  }

  func updateFirstSpend(category: String) {
    titleLabel.text = "\(category)에 가장 많이 \n소비했어요"
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
      label.font = BudgetBuddiesAppFontFamily.Pretendard.medium.font(size: 14)
      label.textColor = BudgetBuddiesAppAsset.AppColor.logoLine2.color
      label.backgroundColor = BudgetBuddiesAppAsset.AppColor.lemon2.color
      label.textAlignment = .center
      label.layer.cornerRadius = 8
      label.layer.borderWidth = 1
      label.layer.borderColor = BudgetBuddiesAppAsset.AppColor.lemon.color.cgColor
      label.layer.masksToBounds = true
      return label
    }()

    let categoryLabel = {
      let label = UILabel()
      label.text = category
      label.font = BudgetBuddiesAppFontFamily.Pretendard.medium.font(size: 14)
      label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
      return label
    }()

    let valueLabel = {
      let label = UILabel()
      label.text = "\(Int(value))"
      label.font = BudgetBuddiesAppFontFamily.Pretendard.medium.font(size: 14)
      label.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
      return label
    }()

    let barView = {
      let view = UIView()
      view.backgroundColor = color
      view.layer.cornerRadius = 4
      view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
      return view
    }()

    [rankLabel, categoryLabel, valueLabel, barView].forEach {
      containerView.addSubview($0)
    }

    rankLabel.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.centerY.equalToSuperview()
      $0.width.equalTo(32)
      $0.height.equalTo(20)

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
      //      $0.leading.equalTo(categoryLabel.snp.trailing).offset(8)
      $0.leading.equalTo(rankLabel.snp.trailing).offset(65)
      $0.centerY.equalToSuperview()
      $0.height.equalTo(24)
      $0.width.equalTo(value * 10)
    }

    return containerView
  }
}
