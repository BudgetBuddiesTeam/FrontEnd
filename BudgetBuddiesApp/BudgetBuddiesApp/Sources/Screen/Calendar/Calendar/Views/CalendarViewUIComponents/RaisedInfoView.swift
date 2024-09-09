//
//  RaisedInfoView.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/30/24.
//

import SnapKit
import UIKit

class RaisedInfoView: UIView {
  // MARK: - Properties
  let infoType: InfoType

  // MARK: - UI Components
  // 왼쪽 뷰
  var leftView: UIView = {
    let view = UIView()
    return view
  }()

  // 타이틀
  var titleLabel: UILabel = {
    let lb = UILabel()
    lb.text = " "
    lb.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 12)
    lb.setCharacterSpacing(-0.3)
    return lb
  }()

  // MARK: - init
  init(title: String, infoType: InfoType) {
    self.titleLabel.text = title
    self.infoType = infoType

    super.init(frame: .zero)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Set up UI
  private func setupUI() {
    self.addSubviews(leftView, titleLabel)

    // 배경
    switch infoType {
    case .discount:
      self.backgroundColor = BudgetBuddiesAppAsset.AppColor.calendarYellow.color
      self.layer.borderColor = UIColor(red: 1, green: 0.83, blue: 0.44, alpha: 1).cgColor
      self.leftView.backgroundColor = UIColor(red: 1, green: 0.7, blue: 0, alpha: 1)
      self.titleLabel.textColor = UIColor(red: 0.35, green: 0.15, blue: 0, alpha: 1)

    case .support:
      self.backgroundColor = BudgetBuddiesAppAsset.AppColor.calendarBlue.color
      self.layer.borderColor = UIColor(red: 0.33, green: 0.78, blue: 1, alpha: 1).cgColor
      self.leftView.backgroundColor = BudgetBuddiesAppAsset.AppColor.coreBlue.color
      self.titleLabel.textColor = UIColor(red: 0, green: 0.18, blue: 0.27, alpha: 1)

    }

    self.layer.borderWidth = 1.0

    self.layer.masksToBounds = true
    self.layer.cornerRadius = 3

    setupConstraints()

  }

  // MARK: - Set up Constraints
  private func setupConstraints() {
    leftView.snp.makeConstraints { make in
      make.leading.top.bottom.equalToSuperview()
      make.width.equalTo(6)
    }

    titleLabel.snp.makeConstraints { make in
      make.leading.equalTo(leftView.snp.trailing).offset(2)
      make.trailing.equalToSuperview()
      make.top.bottom.equalToSuperview()
      make.centerY.equalToSuperview()
    }
  }
}
