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
    view.setShadow(opacity: 1, Radius: 5, offSet: CGSize(width: 0, height: 0))
    return view
  }()

  let logoImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.layer.cornerRadius = 15
    imageView.layer.masksToBounds = true
    imageView.setShadow(opacity: 1, Radius: 3.6, offSet: CGSize(width: 0, height: 0))
    return imageView
  }()

  let titleLabel = {
    let label = UILabel()
    label.text = " "
    label.setCharacterSpacing(-0.35)
    label.font = BudgetBuddiesAppFontFamily.Pretendard.medium.font(size: 14)
    label.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    return label
  }()

  let amountLabel = {
    let label = UILabel()
    label.text = " "
    label.setCharacterSpacing(-0.4)
    label.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 16)
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    return label
  }()

  let progressBar = {
    let progressView = UIProgressView(progressViewStyle: .default)
    progressView.progressTintColor = BudgetBuddiesAppAsset.AppColor.coreYellow.color
    progressView.trackTintColor = BudgetBuddiesAppAsset.AppColor.circleStroke.color
    progressView.layer.cornerRadius = 5
    progressView.clipsToBounds = true
    return progressView
  }()

  let consumptionLabel = {
    let label = UILabel()
    label.text = " "
    label.setCharacterSpacing(-0.3)
    label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 12)
    label.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    return label
  }()

  let remainingLabel = {
    let label = UILabel()
    label.text = " "
    label.setCharacterSpacing(-0.3)
    label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 12)
    label.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
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
      $0.leading.trailing.equalToSuperview().inset(16)
      $0.top.bottom.equalToSuperview().inset(7)
    }

    logoImageView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().inset(16)
      $0.width.height.equalTo(48)
    }

    titleLabel.snp.makeConstraints {
      $0.top.equalTo(logoImageView.snp.top).offset(5)
      $0.leading.equalTo(logoImageView.snp.trailing).offset(11)
    }

    amountLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom)
      make.leading.equalTo(logoImageView.snp.trailing).offset(11)
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
