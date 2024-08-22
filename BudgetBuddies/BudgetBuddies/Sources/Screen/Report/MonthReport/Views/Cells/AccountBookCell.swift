//
//  AccountBookCell.swift
//  BudgetBuddies
//
//  Created by 이승진 on 8/1/24.
//

import SnapKit
import UIKit

final class AccountBookCell: UITableViewCell {

  // MARK: - Properties
  static let identifier = "AccountBookCell"

  // MARK: - UI Components

  //    let dateLabel = {
  //        let label = UILabel()
  //        label.font = BudgetBuddiesFontFamily.Pretendard.regular.font(size: 14)
  //        label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
  //        return label
  //    }()

  let iconImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFit
    image.setShadow(opacity: 1, Radius: 3.6, offSet: CGSize(width: 0, height: 0))
    return image
  }()

  let descriptionLabel = {
    let label = UILabel()
    label.font = BudgetBuddiesFontFamily.Pretendard.medium.font(size: 14)
    label.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    return label
  }()

  let amountLabel = {
    let label = UILabel()
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 16)
    label.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    return label
  }()

  //    let moreButton = {
  //        let button = UIButton(type: .custom)
  //        button.setTitle("더보기 >", for: .normal)
  //        button.setTitleColor(BudgetBuddiesAsset.AppColor.subGray.color, for: .normal)
  //        button.titleLabel?.font = BudgetBuddiesFontFamily.Pretendard.regular.font(size: 14)
  //        return button
  //    }()

  // 초기화 메서드
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    setup()
    setConst()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    contentView.backgroundColor = .white

    [iconImageView, amountLabel, descriptionLabel].forEach {
      contentView.addSubview($0)
    }
  }

  private func setConst() {
    //        dateLabel.snp.makeConstraints {
    //            $0.top.leading.equalToSuperview().offset(16)
    //        }
    iconImageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(24)
      $0.width.height.equalTo(48)
    }

    amountLabel.snp.makeConstraints {
      $0.top.equalTo(iconImageView.snp.top).offset(5)
      $0.leading.equalTo(iconImageView.snp.trailing).offset(20)
    }

    descriptionLabel.snp.makeConstraints {
      $0.leading.equalTo(amountLabel)
      $0.top.equalTo(amountLabel.snp.bottom).offset(2)
    }

    //        moreButton.snp.makeConstraints {
    //            $0.bottom.trailing.equalToSuperview().offset(-16)
    //        }
  }

  func configure(with accountBook: AccountBookModel) {
    //        dateLabel.text = accountBook.date
    iconImageView.image = accountBook.icon
    amountLabel.text = accountBook.amount
    descriptionLabel.text = accountBook.description
  }

}

struct AccountBookModel {
  //    let date: String
  let icon: UIImage
  let amount: String
  let description: String
}
