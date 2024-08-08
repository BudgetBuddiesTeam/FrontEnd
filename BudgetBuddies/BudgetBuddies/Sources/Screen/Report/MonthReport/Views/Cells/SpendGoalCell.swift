//
//  SpendGoalCell.swift
//  BudgetBuddies
//
//  Created by 이승진 on 7/31/24.
//

import SnapKit
import UIKit

final class SpendGoalCell: UITableViewCell {

  // MARK: - Properties
  static let identifier = "SpendGoalCell"

  // MARK: - UI Components
  let backView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 15
    view.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
    view.layer.shadowOpacity = 1
    view.layer.shadowRadius = 10
    view.layer.masksToBounds = false
    return view
  }()

  let logoImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.layer.cornerRadius = 15
    imageView.layer.masksToBounds = true
    return imageView
  }()

  let titleLabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    label.textColor = .black
    return label
  }()

  let amountLabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    label.textColor = .black
    return label
  }()

  let progressBar = {
    let progressView = UIProgressView(progressViewStyle: .default)
    progressView.progressTintColor = BudgetBuddiesAsset.AppColor.coreYellow.color
    progressView.trackTintColor = BudgetBuddiesAsset.AppColor.circleStroke.color
    progressView.layer.cornerRadius = 5
    progressView.clipsToBounds = true
    return progressView
  }()

  let consumptionLabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    label.textColor = .gray
    return label
  }()

  let remainingLabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    label.textColor = .gray
    return label
  }()

  // MARK: - Initialization
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
    setConsts()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup
  private func setup() {
    backgroundColor = .clear
    contentView.addSubview(backView)

    [logoImageView, titleLabel, amountLabel, progressBar, consumptionLabel, remainingLabel].forEach
    {
      backView.addSubview($0)
    }
  }

  // MARK: - Setup Constraints
  private func setConsts() {
    backView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(8)
    }

    logoImageView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().inset(16)
      $0.width.height.equalTo(48)
    }

    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(16)
      $0.leading.equalTo(logoImageView.snp.trailing).offset(16)
    }

    amountLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(4)
      make.leading.equalTo(logoImageView.snp.trailing).offset(16)
    }

    progressBar.snp.makeConstraints { make in
      make.top.equalTo(logoImageView.snp.bottom).offset(16)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(10)
    }

    consumptionLabel.snp.makeConstraints { make in
      make.top.equalTo(progressBar.snp.bottom).offset(8)
      make.leading.equalToSuperview().inset(16)
    }

    remainingLabel.snp.makeConstraints { make in
      make.top.equalTo(progressBar.snp.bottom).offset(8)
      make.trailing.equalToSuperview().inset(16)
    }
  }

  // MARK: - Configure Cell
  func configure(with spendGoal: SpendGoalModel) {
    logoImageView.image = spendGoal.categoryImage
    titleLabel.text = spendGoal.title
    amountLabel.text = "\(spendGoal.amount)원"
    progressBar.progress = spendGoal.progress
    consumptionLabel.text = "소비 \(spendGoal.consumption)원"
    remainingLabel.text = "잔여 \(spendGoal.remaining)원"
  }
}

// Model to be used for configuration
struct SpendGoalModel {
  let categoryImage: UIImage
  let title: String
  let amount: String
  let progress: Float
  let consumption: String
  let remaining: String
}
