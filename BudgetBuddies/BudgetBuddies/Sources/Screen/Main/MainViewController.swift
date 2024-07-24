//
//  MainViewController.swift
//  BudgetBuddies
//
//  Created by 이승진 on 7/24/24.
//

import Charts
import DGCharts
import SnapKit
import UIKit

final class MainViewController: UIViewController {

  let titleLabel = {
    let label = UILabel()
    label.text = "홈"
    label.textColor = .black
    label.font = .systemFont(ofSize: 22, weight: .semibold)
    return label
  }()

  let monthNaviButton = {
    let button = UIButton(type: .custom)
    button.setTitle("이번 달 레포트", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    button.layer.cornerRadius = 10
    button.layer.masksToBounds = true
    button.layer.borderWidth = 1
    button.layer.borderColor =
      UIColor(red: 255 / 255, green: 208 / 255, blue: 29 / 255, alpha: 1).cgColor
    button.backgroundColor = UIColor(red: 255 / 255, green: 208 / 255, blue: 29 / 255, alpha: 1)
    button.addTarget(self, action: #selector(monthNaviButtonTapped), for: .touchUpInside)
    return button
  }()

  let analysisNaviButton = {
    let button = UIButton(type: .custom)
    button.setTitle("비교 분석 레포트", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    button.layer.cornerRadius = 10
    button.layer.masksToBounds = true
    button.layer.borderWidth = 1
    button.layer.borderColor =
      UIColor(red: 255 / 255, green: 208 / 255, blue: 29 / 255, alpha: 1).cgColor
    button.backgroundColor = UIColor(red: 255 / 255, green: 208 / 255, blue: 29 / 255, alpha: 1)
    button.addTarget(self, action: #selector(analysisNaviButtonTapped), for: .touchUpInside)
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    view.addSubview(titleLabel)
    view.addSubview(monthNaviButton)
    view.addSubview(analysisNaviButton)

    setConst()
  }

  func setConst() {
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
      $0.leading.equalToSuperview().offset(16)
    }

    monthNaviButton.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
      $0.width.equalTo(360)
      $0.height.equalTo(60)
    }

    analysisNaviButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview().offset(-100)
      $0.width.equalTo(360)
      $0.height.equalTo(60)
    }
  }

  @objc func monthNaviButtonTapped() {
    if let naviController = self.navigationController {
      let MonthReportVC = MonthReportViewController()
      naviController.pushViewController(MonthReportVC, animated: true)
    }
  }

  @objc func analysisNaviButtonTapped() {
    if let naviController = self.navigationController {
      let AnalysisReportVC = AnalysisReportViewController()
      naviController.pushViewController(AnalysisReportVC, animated: true)
    }
  }
}
