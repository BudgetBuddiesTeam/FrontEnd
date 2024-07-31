//
//  CustomInfoColor.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/25/24.
//

import SnapKit
import UIKit

class CustomInfoColor: UIView {

//  enum InfoType {
//    case discount
//    case support
//  }
    
    var infoType: InfoType

  // MARK: - Properties
  let colorView: UIView = {
    let view = UIView()
    view.layer.masksToBounds = true
    view.layer.cornerRadius = 4
    return view
  }()

  let infoLabel: UILabel = {
    let lb = UILabel()
    lb.font = BudgetBuddiesFontFamily.Pretendard.regular.font(size: 12)
    lb.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
    return lb
  }()

  lazy var stackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [colorView, infoLabel])
    sv.axis = .horizontal
    sv.spacing = 7
    sv.alignment = .fill
    sv.distribution = .fill
    return sv
  }()

  // MARK: - override init
  init(infoType: InfoType) {
      self.infoType = infoType
    super.init(frame: .zero)

    switch infoType {
    case .discount:
      self.colorView.backgroundColor = UIColor(red: 1, green: 0.7, blue: 0, alpha: 1)
      self.infoLabel.text = "할인정보"
      self.infoLabel.setCharacterSpacing(-0.3)
    case .support:
      self.colorView.backgroundColor = BudgetBuddiesAsset.AppColor.coreBlue.color
      self.infoLabel.text = "지원정보"
      self.infoLabel.setCharacterSpacing(-0.3)
    }

    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Set up UI
  private func setupUI() {
    self.backgroundColor = .clear
    self.addSubview(stackView)

    setupConstraints()
  }

  // MARK: - Set up Constraints
  private func setupConstraints() {
    colorView.snp.makeConstraints { make in
      make.height.width.equalTo(15)
    }

    infoLabel.snp.makeConstraints { make in
      make.height.equalTo(15)
    }

    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
