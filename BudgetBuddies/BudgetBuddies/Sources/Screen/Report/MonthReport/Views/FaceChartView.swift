//
//  FaceChartView.swift
//  BudgetBuddies
//
//  Created by 이승진 on 7/24/24.
//

import DGCharts
import SnapKit
import UIKit

final class FaceChartView: UIView {
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.setShadow(opacity: 1, Radius: 5, offSet: CGSize(width: 0, height: -1))
        return view
    }()
    
  let monthLabel = {
    let label = UILabel()
    label.text = "8월"
      label.setCharacterSpacing(-0.4)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 16)
    label.textAlignment = .center
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
    image.image = BudgetBuddiesAsset.AppImage.Face.basicFace.image
    image.contentMode = .scaleAspectFit
    return image
  }()

  let commentView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.coreYellow.color
    view.layer.cornerRadius = 14
    view.layer.borderColor = BudgetBuddiesAsset.AppColor.logoLine1.color.cgColor
    view.layer.borderWidth = 1
      view.setShadow(opacity: 1, Radius: 3.28, offSet: CGSize(width: 0, height: 0.82))
    return view
  }()

  let commentLabel = {
    let label = UILabel()
    label.text = "이번달에는 유흥에 1만원 이상 쓰면 안돼요!"
    label.textColor = .white
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
    label.textAlignment = .center
    return label
  }()

  let spendTitleLabel = {
    let label = UILabel()
    label.text = "총 소비액"
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
    label.textAlignment = .center
    return label
  }()

  let remainTitleLabel = {
    let label = UILabel()
    label.text = "총 잔여액"
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
    label.textAlignment = .center
    return label
  }()

  let totalSpendLabel = {
    let label = UILabel()
    label.text = "612,189원"
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 16)
    label.textAlignment = .center
    return label
  }()

  let totalRemainLabel = {
    let label = UILabel()
    label.text = "112,189원"
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 16)
    label.textAlignment = .center
    return label
  }()

  let separatorView = {
    let view = UIView()
    view.backgroundColor = .lightGray
    return view
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
      self.addSubviews(backView)
      
    [beforeButton, monthLabel, afterButton].forEach {
      self.monthStackView.addArrangedSubview($0)
    }

    [
      monthStackView, pieChartView, centerImageView, commentView, commentLabel, spendTitleLabel,
      totalSpendLabel, separatorView, remainTitleLabel, totalRemainLabel,
    ].forEach {
      backView.addSubview($0)
    }

    commentView.addSubview(commentLabel)
  }

  private func setConst() {
      backView.snp.makeConstraints { make in
          make.leading.trailing.top.equalToSuperview()
          make.bottom.equalTo(self.separatorView.snp.bottom).offset(20)
      }
      
    beforeButton.snp.makeConstraints {
      $0.width.equalTo(4)
      $0.height.equalTo(14)
    }

    afterButton.snp.makeConstraints {
      $0.width.equalTo(4)
      $0.height.equalTo(14)
    }

    monthStackView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(20)
      $0.leading.equalToSuperview().offset(100)
      $0.trailing.equalToSuperview().offset(-100)
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
      $0.top.equalTo(pieChartView.snp.bottom).offset(16)
        $0.leading.trailing.equalToSuperview().inset(43)
    }

    commentLabel.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(8)
    }
      
    spendTitleLabel.snp.makeConstraints {
      $0.top.equalTo(commentView.snp.bottom).offset(30)
      $0.leading.equalToSuperview().offset(70)
    }

    totalSpendLabel.snp.makeConstraints {
      $0.top.equalTo(spendTitleLabel.snp.bottom).offset(4)
      $0.centerX.equalTo(spendTitleLabel)
    }

    separatorView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(spendTitleLabel.snp.top)
      $0.bottom.equalTo(totalSpendLabel.snp.bottom)
      $0.width.equalTo(1)
    }

    remainTitleLabel.snp.makeConstraints {
      $0.top.equalTo(commentView.snp.bottom).offset(30)
      $0.trailing.equalToSuperview().offset(-70)
    }

    totalRemainLabel.snp.makeConstraints {
      $0.top.equalTo(remainTitleLabel.snp.bottom).offset(4)
      $0.centerX.equalTo(remainTitleLabel)
    }
  }

  func setupChart(entries: [PieChartDataEntry]) {
    let dataSet = PieChartDataSet(entries: entries, label: "")
    dataSet.colors = [
      BudgetBuddiesAsset.AppColor.coreYellow.color, BudgetBuddiesAsset.AppColor.strokeGray1.color,
    ]
    dataSet.drawValuesEnabled = false
    dataSet.sliceSpace = 2
    dataSet.selectionShift = 5  // 슬라이스의 두께를 줄임

    let data = PieChartData(dataSet: dataSet)
    pieChartView.data = data

    pieChartView.usePercentValuesEnabled = false
    pieChartView.drawHoleEnabled = true
    pieChartView.holeRadiusPercent = 0.75  // 구멍 크기를 키우기
    pieChartView.transparentCircleRadiusPercent = 0.76
    pieChartView.chartDescription.enabled = false
    pieChartView.legend.enabled = false
    pieChartView.notifyDataSetChanged()
    pieChartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)  // 애니메이션을 추가
  }

  func updateCenterImage(image: UIImage?) {
    centerImageView.image = image
  }

  func updateLabels(spend: String, remain: String) {
    totalSpendLabel.text = spend
    totalRemainLabel.text = remain
  }
}
