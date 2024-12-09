//
//  NotificationInfoCell.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 12/9/24.
//

import SnapKit
import UIKit

class NotificationInfoCell: UITableViewCell {
  static let identifier = "NotificationCell"

  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
    label.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    return label
  }()

  let toggleSwitch: UISwitch = {
    let toggle = UISwitch()
    toggle.onTintColor = BudgetBuddiesAppAsset.AppColor.coreYellow.color
    return toggle
  }()

  let separatorView = UIView()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupLayout() {
    contentView.addSubview(titleLabel)
    contentView.addSubview(toggleSwitch)
    contentView.addSubview(separatorView)

    titleLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().inset(16)
    }

    toggleSwitch.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.trailing.equalToSuperview().inset(16)
    }

    separatorView.backgroundColor = BudgetBuddiesAppAsset.AppColor.barGray.color
    separatorView.snp.makeConstraints { make in
      make.height.equalTo(1)
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
      make.bottom.equalToSuperview()
    }
  }

  func configure(with model: NotificationInfoModel) {
    titleLabel.text = model.title
    toggleSwitch.isOn = model.isEnabled
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
