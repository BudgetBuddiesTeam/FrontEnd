//
//  ReportTableViewCell.swift
//  BudgetBuddies
//
//  Created by 이승진 on 8/5/24.
//

import SnapKit
import UIKit

final class ReportTableViewCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "ReportTableViewCell"

  // MARK: - UI Components
  let backView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 15
      view.setShadow(opacity: 1, Radius: 5, offSet: CGSize(width: 0, height: 1))
    view.layer.masksToBounds = false
    return view
  }()

  let rankLabel = {
    let label = UILabel()
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 16)
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    return label
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
      label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 16)
      label.setCharacterSpacing(-0.4)
      label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    return label
  }()

  let amountLabel = {
    let label = UILabel()
      label.text = " "
      label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
      label.setCharacterSpacing(-0.35)
      label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    return label
  }()

  let descriptionLabel = {
    let label = UILabel()
    label.text = "나는 평균보다 50,000원 더 계획했어요"
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
    label.backgroundColor = BudgetBuddiesAsset.AppColor.textBox.color
    label.textAlignment = .center
    label.layer.cornerRadius = 8
    label.layer.masksToBounds = true
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

    [logoImageView, rankLabel, titleLabel, amountLabel, descriptionLabel].forEach {
      backView.addSubview($0)
    }
  }

  // MARK: - Setup Constraints
  private func setConsts() {
    backView.snp.makeConstraints {
        $0.top.bottom.equalToSuperview().inset(8)
        $0.leading.trailing.equalToSuperview().inset(16)
    }

    logoImageView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().inset(24)
      $0.width.height.equalTo(48)
    }

    rankLabel.snp.makeConstraints {
      $0.centerY.equalTo(logoImageView)
      $0.trailing.equalTo(logoImageView.snp.leading).offset(-4)
    }

    titleLabel.snp.makeConstraints {
      $0.top.equalTo(logoImageView.snp.top).offset(5)
      $0.leading.equalTo(logoImageView.snp.trailing).offset(16)
    }

    amountLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(2)
      $0.leading.equalTo(logoImageView.snp.trailing).offset(16)
    }

    descriptionLabel.snp.makeConstraints {
        $0.height.equalTo(34)
        $0.leading.trailing.equalToSuperview().inset(12)
      $0.bottom.equalToSuperview().offset(-12)
    }
  }

  // MARK: - Configure Cell
  func configure(with report: ReportModel) {
    logoImageView.image = report.categoryImage
    rankLabel.text = report.rank
    titleLabel.text = report.title
    amountLabel.text = "\(report.amount)원"
    let text = "나는 평균보다 \(report.description)원 더 계획했어요"
    let attributedText = NSMutableAttributedString(string: text)

    // categoryName의 범위를 찾아서 색상 변경
    let range = (text as NSString).range(of: report.description)
    attributedText.addAttribute(
      .foregroundColor, value: BudgetBuddiesAsset.AppColor.logoLine2.color, range: range)  // Set your desired color

    descriptionLabel.attributedText = attributedText
  }
}

struct ReportModel {
  let categoryImage: UIImage
  let rank: String
  let title: String
  let amount: String
  let description: String
}
