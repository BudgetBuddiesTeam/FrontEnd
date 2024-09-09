//
//  MonthCell.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/29/24.
//

import SnapKit
import UIKit

class MonthCell: UICollectionViewCell {
  // MARK: - Properties
  static let identifier = "MonthCell"

  // MARK: - UI Components
  var backView: UIView = {
    let view = UIView()
    view.layer.masksToBounds = true
    view.layer.cornerRadius = 17
    return view
  }()

  var monthLabel: UILabel = {
    let lb = UILabel()
    lb.text = " "
    lb.font = BudgetBuddiesAppFontFamily.Pretendard.medium.font(size: 16)
    lb.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    lb.setCharacterSpacing(-0.4)
    lb.textAlignment = .center
    return lb
  }()

  // MARK: - override init
  override init(frame: CGRect) {
    super.init(frame: frame)

    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Set up UI
  private func setupUI() {
    self.contentView.addSubview(backView)
    backView.addSubview(monthLabel)

    setupConstraints()
  }

  // MARK: - Set up Constraints
  private func setupConstraints() {
    backView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    monthLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(4)
      make.leading.trailing.equalToSuperview()
    }
  }
}
