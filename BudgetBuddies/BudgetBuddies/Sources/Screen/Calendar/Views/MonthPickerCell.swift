//
//  MonthPickerCell.swift
//  BudgetBuddiesLocal
//
//  Created by 김승원 on 7/22/24.
//

import UIKit

class MonthPickerCell: UICollectionViewCell {
  // MARK: - Properties
  let backView: UIView = {
    let view = UIView()
    //        view.backgroundColor = .red
    view.layer.masksToBounds = true
    view.layer.cornerRadius = 17
    return view
  }()

  let monthLabel: UILabel = {
    let lb = UILabel()
    lb.font = UIFont(name: "Pretendard-Medium", size: 16)
    lb.textAlignment = .center
    let attributedString = NSMutableAttributedString(string: lb.text ?? "")
    let letterSpacing: CGFloat = -0.4
    attributedString.addAttribute(
      .kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
    lb.textColor = #colorLiteral(
      red: 0.4627450705, green: 0.4627450705, blue: 0.4627450705, alpha: 1)
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
      make.leading.trailing.equalToSuperview().inset(32)
    }
  }
}
