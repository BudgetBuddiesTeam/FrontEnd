//
//  InfoTitleWithButtonView.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/12/24.
//

import SnapKit
import UIKit

class InfoTitleWithButtonView: UIView {
  // MARK: - Properties
  var infoType: InfoType?

  // 이 값이 변경될 때마다 "전체보기 >" 버튼의 색을 바꿈 (비활성화일 때는 배경색과 동일하게)
  var isEnabled: Bool = true {
    didSet {
      updateColor()
    }
  }

  // MARK: - UI Components
  // 세미볼드체 타이틀
  var infoTitleLabel: UILabel = {
    let lb = UILabel()
    lb.text = " "
    lb.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 22)
    lb.setCharacterSpacing(-0.55)
    lb.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    return lb
  }()

  // 전체보기 텍스트
  var showDetailLabel: UILabel = {
    let lb = UILabel()
    lb.text = "전체보기"
    lb.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 14)
    lb.setCharacterSpacing(-0.35)
    lb.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    return lb
  }()

  // 전체보기 chevron
  var chevronImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(systemName: "chevron.right")
    iv.contentMode = .scaleAspectFit
    iv.tintColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    return iv
  }()

  // 전체보기 스택뷰
  lazy var showDetailStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [showDetailLabel, chevronImageView])
    sv.axis = .horizontal
    sv.spacing = 2
    sv.alignment = .center
    sv.distribution = .fill

    // 제스처 추가
    sv.isUserInteractionEnabled = true
    return sv
  }()

  // MARK: - init ⭐️
  init(infoType: InfoType) {
    super.init(frame: .zero)

    self.infoType = infoType

    switch infoType {
    case .discount:
      infoTitleLabel.text = "할인정보"
    case .support:
      infoTitleLabel.text = "지원정보"
    }

    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Update Color
  private func updateColor() {
    let color: UIColor =
      isEnabled
      ? BudgetBuddiesAppAsset.AppColor.subGray.color
      : BudgetBuddiesAppAsset.AppColor.background.color
    showDetailLabel.textColor = color
    chevronImageView.tintColor = color

  }

  // MARK: - set up UI
  private func setupUI() {
    self.backgroundColor = .clear
    self.addSubviews(infoTitleLabel, showDetailStackView)

    setupConstraints()
  }

  // MARK: - set up Constraints
  private func setupConstraints() {
    infoTitleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(6)
    }

    showDetailLabel.snp.makeConstraints { make in
      make.height.equalTo(21)
      make.width.equalTo(48)
    }

    chevronImageView.snp.makeConstraints { make in
      make.width.equalTo(16)
      make.height.equalTo(16)
    }

    showDetailStackView.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(16 + 5)
      make.bottom.equalToSuperview().inset(3)
    }
  }
}
