//
//  TopStackView.swift
//  BudgetBuddies
//
//  Created by 이승진 on 7/24/24.
//

import SnapKit
import UIKit

final class TopStackView: UIView {

  let titleLabel = {
    let label = UILabel()
    label.text = "제목"
    label.setCharacterSpacing(-0.45)
    label.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 18)
    label.font = .systemFont(ofSize: 18, weight: .semibold)
    label.textColor = .black
    return label
  }()

  lazy var totalButton = {
    let button = UIButton(type: .custom)
    button.setTitle("전체보기", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
    button.setTitleColor(.lightGray, for: .normal)
    button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    button.tintColor = .lightGray
    button.semanticContentAttribute = .forceRightToLeft
    button.contentVerticalAlignment = .center
    button.contentHorizontalAlignment = .leading
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    setConst()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  private func setup() {
    addSubview(titleLabel)
    addSubview(totalButton)

  }

  private func setConst() {
    self.snp.makeConstraints {
      $0.height.equalTo(100)
      $0.width.equalTo(UIScreen.main.bounds.width)
    }

    titleLabel.snp.makeConstraints {
      $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(0)
      $0.bottom.equalToSuperview().offset(-10)
    }

    totalButton.snp.makeConstraints {
      $0.height.equalTo(18)
      $0.width.equalTo(80)
      $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(0)
      $0.bottom.equalToSuperview().offset(-10)
    }

  }

}
