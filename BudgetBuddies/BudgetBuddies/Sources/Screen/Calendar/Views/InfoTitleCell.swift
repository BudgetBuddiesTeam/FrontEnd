//
//  InfoTitleCell.swift
//  BudgetBuddiesLocal
//
//  Created by 김승원 on 7/15/24.
//

import UIKit

protocol InfoTitleCellDelegate: AnyObject {
  func didTapShowDetailViewButton(in cell: InfoTitleCell, infoType: InfoTitleCell.InfoType)
}

final class InfoTitleCell: UITableViewCell {
  weak var delegate: InfoTitleCellDelegate?

  enum InfoType {
    case discount
    case support
  }

  var currentInfoType: InfoType?

  // MARK: - Properties
  private let infoLabel: UILabel = {
    let lb = UILabel()
    lb.font = UIFont(name: "Pretendard-SemiBold", size: 22)
    let attributedString = NSMutableAttributedString(string: lb.text ?? "")
    let letterSpacing: CGFloat = -0.55
    attributedString.addAttribute(
      .kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
    lb.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    return lb
  }()

  private let showDetailLabel: UILabel = {
    let lb = UILabel()
    lb.text = "전체보기"
    lb.font = UIFont(name: "Pretendard-Regular", size: 14)
    let attributedString = NSMutableAttributedString(string: lb.text ?? "")
    let letterSpacing: CGFloat = -0.35
    attributedString.addAttribute(
      .kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
    lb.textColor = #colorLiteral(
      red: 0.4627450705, green: 0.4627450705, blue: 0.4627450705, alpha: 1)
    return lb
  }()

  private let chevronImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "chevron.left")
    iv.contentMode = .scaleAspectFit
    iv.tintColor = #colorLiteral(
      red: 0.4627450705, green: 0.4627450705, blue: 0.4627450705, alpha: 1)
    return iv
  }()

  private lazy var stackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [showDetailLabel, chevronImageView])
    sv.axis = .horizontal
    sv.spacing = 4
    sv.alignment = .center
    sv.distribution = .fill

    sv.isUserInteractionEnabled = true

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapStackView))
    sv.addGestureRecognizer(tapGesture)
    return sv
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
    self.addSubview(infoLabel)
    self.contentView.addSubview(stackView)

    setupConstraints()
  }

  // MARK: - Set up Constraints
  private func setupConstraints() {
    infoLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(6)
    }

    showDetailLabel.snp.makeConstraints { make in
      make.height.equalTo(21)
      make.width.equalTo(50)
    }

    chevronImageView.snp.makeConstraints { make in
      make.width.equalTo(6)
    }

    stackView.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(6)
    }
  }

  // MARK: - Configure
  func configure(infoType: InfoType) {
    self.currentInfoType = infoType

    switch infoType {
    case .discount:
      infoLabel.text = "할인정보"
    case .support:
      infoLabel.text = "지원정보"
    }
    let attributedString = NSMutableAttributedString(string: infoLabel.text ?? "")
    let letterSpacing: CGFloat = -0.55
    attributedString.addAttribute(
      .kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
    infoLabel.attributedText = attributedString
  }

  // MARK: - Selectors
  @objc private func didTapStackView() {
    print(#function)
    guard let infoType = currentInfoType else { return }
    delegate?.didTapShowDetailViewButton(in: self, infoType: infoType)
  }
}
