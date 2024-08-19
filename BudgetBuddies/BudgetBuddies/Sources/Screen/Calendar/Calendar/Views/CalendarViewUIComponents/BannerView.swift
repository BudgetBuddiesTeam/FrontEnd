//
//  BannerView.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/12/24.
//

import SnapKit
import UIKit

class BannerView: UIView {
  // MARK: - UI Componenets
  // 뒷 배경
  var backView: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.coreYellow.color
    view.layer.cornerRadius = 15
    view.layer.borderWidth = 1.0
    view.layer.borderColor = BudgetBuddiesAsset.AppColor.logoLine1.color.cgColor

    view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
    view.layer.shadowOpacity = 1
    view.layer.shadowRadius = 10  //반경
    view.layer.shadowOffset = CGSize(width: 0, height: 0)
    view.layer.masksToBounds = false

    return view
  }()

  // "주머니 채우는" 라벨
  var fillPoketLabel: UILabel = {
    let lb = UILabel()
    lb.text = "주머니 채우는"
    lb.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 12)
    lb.setCharacterSpacing(-0.3)
    lb.textColor = UIColor(red: 0.4, green: 0.34, blue: 0.34, alpha: 0.7)
    return lb
  }()

  // "주머니 캘린더" 라벨
  var poketCalendarLabel: UILabel = {
    let lb = UILabel()
    lb.text = "주머니 캘린더"
    lb.setCharacterSpacing(-0.45)
    lb.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 18)
    lb.textColor = BudgetBuddiesAsset.AppColor.white.color
    return lb
  }()

  // 라벨 스택뷰
  lazy var labelStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [fillPoketLabel, poketCalendarLabel])
    sv.axis = .vertical
    sv.spacing = 3
    sv.alignment = .leading
    sv.distribution = .fill
    return sv
  }()

  // 캘린더 이미지
  var calendarImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "calendarImage")
    iv.contentMode = .scaleAspectFit
    return iv
  }()

  // MARK: - Init ⭐️
  override init(frame: CGRect) {
    super.init(frame: frame)

    SetupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Set up UI
  private func SetupUI() {
    self.backgroundColor = .clear

    self.addSubviews(backView, calendarImageView)
    backView.addSubviews(labelStackView)

    setupConstraints()

  }

  // MARK: - Set up Constraints
  private func setupConstraints() {
    backView.snp.makeConstraints { make in
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

    labelStackView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(12)
      make.leading.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(7)
      make.height.equalTo(45)
    }

    calendarImageView.snp.makeConstraints { make in
      make.trailing.equalTo(backView).inset(12)
      make.bottom.equalTo(backView).inset(5)
      make.height.equalTo(88 + 10)
      make.width.equalTo(98 + 10)
    }
  }
}
