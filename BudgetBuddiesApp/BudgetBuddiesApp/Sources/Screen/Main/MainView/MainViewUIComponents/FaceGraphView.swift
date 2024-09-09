//
//  FaceGraphView.swift
//  BudgetBuddies
//
//  Created by 이승진 on 8/21/24.
//

import DGCharts
import SnapKit
import UIKit

final class FaceGraphView: UIView {
  let pieChartView = PieChartView()

  let centerImageView = {
    let image = UIImageView()
    image.image = BudgetBuddiesAppAsset.AppImage.Face.basicFace.image
    image.contentMode = .scaleAspectFit
    return image
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setup()
    setConsts()
  }

  private func setup() {

    [pieChartView, centerImageView].forEach {
      self.addSubview($0)
    }
  }

  private func setConsts() {
    pieChartView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    centerImageView.snp.makeConstraints {
      $0.center.equalTo(pieChartView)
      $0.width.height.equalTo(pieChartView.snp.width).multipliedBy(0.8)
    }
  }

  func setupChart(entries: [PieChartDataEntry]) {
    let dataSet = PieChartDataSet(entries: entries, label: "")
    dataSet.colors = [
      BudgetBuddiesAppAsset.AppColor.coreYellow.color, BudgetBuddiesAppAsset.AppColor.strokeGray1.color,
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

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}
