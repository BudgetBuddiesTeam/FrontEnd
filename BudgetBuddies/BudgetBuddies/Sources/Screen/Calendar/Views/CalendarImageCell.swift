//
//  CalendarImageCell.swift
//  BudgetBuddiesLocal
//
//  Created by 김승원 on 7/15/24.
//

import SnapKit
import UIKit

class CalendarImageCell: UITableViewCell {
  // MARK: - Properties
  private let yellowBackView: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.8164488077, blue: 0.1144857034, alpha: 1)
    view.layer.cornerRadius = 15
    view.layer.borderWidth = 1.0
    view.layer.borderColor = #colorLiteral(
      red: 0.9984216094, green: 0.7218663096, blue: 0.01596412808, alpha: 1)

    view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
    view.layer.shadowOpacity = 1
    view.layer.shadowRadius = 10  //반경
    view.layer.shadowOffset = CGSize(width: 0, height: 0)  //위치조정
    view.layer.masksToBounds = false  //
    return view
  }()

  private let fillPoketLabel: UILabel = {
    let lb = UILabel()
    lb.text = "주머니 채우는"
    lb.font = UIFont(name: "Pretendard-SemiBold", size: 12)
    //        lb.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    let attributedString = NSMutableAttributedString(string: lb.text ?? "")
    let letterSpacing: CGFloat = -0.3
    attributedString.addAttribute(
      .kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
    lb.textColor = #colorLiteral(
      red: 0.5812363625, green: 0.4784846902, blue: 0.272742033, alpha: 1)
    return lb
  }()

  private let poketCalendarLabel: UILabel = {
    let lb = UILabel()
    lb.text = "주머니 캘린더"
    lb.font = UIFont(name: "Pretendard-SemiBold", size: 18)
    //        lb.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    lb.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    let attributedString = NSMutableAttributedString(string: lb.text ?? "")
    let letterSpacing: CGFloat = -0.45
    attributedString.addAttribute(
      .kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
    lb.attributedText = attributedString
    return lb
  }()

  private lazy var stackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [fillPoketLabel, poketCalendarLabel])
    sv.axis = .vertical
    sv.spacing = 3
    sv.alignment = .leading
    sv.distribution = .fill
    return sv
  }()

  private let calendarImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "calendar")
    iv.contentMode = .scaleAspectFit
    return iv
  }()

  // MARK: - override init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = .none

    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Set up UI
  private func setupUI() {
    self.backgroundColor = .clear
    self.addSubview(yellowBackView)
    yellowBackView.addSubview(stackView)
    self.addSubview(calendarImageView)

    setupConstraints()
  }

  // MARK: - Set up Constraints
  private func setupConstraints() {
    yellowBackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(17)
      make.height.equalTo(64)
      make.centerX.equalToSuperview()
    }

    fillPoketLabel.snp.makeConstraints { make in
      make.height.equalTo(15)
    }

    poketCalendarLabel.snp.makeConstraints { make in
      make.height.equalTo(27)
    }

    stackView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(12)
      make.leading.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(7)
      make.height.equalTo(45)
    }

    calendarImageView.snp.makeConstraints { make in
      make.trailing.equalTo(yellowBackView).inset(12)
      make.bottom.equalTo(yellowBackView).inset(5)
      make.height.equalTo(88 + 10)
      make.width.equalTo(98 + 10)
    }

  }
}
