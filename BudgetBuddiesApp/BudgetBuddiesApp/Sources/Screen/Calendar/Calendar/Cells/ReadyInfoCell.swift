//
//  ReadyInfoCell.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/14/24.
//

import SnapKit
import UIKit

class ReadyInfoCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "ReadyInfoCell"

  //    var infoType: InfoType?

  // MARK: - UI Components
  // 표정 이미지 뷰
  var readyImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "readyInfoImage")
    iv.contentMode = .scaleAspectFit
    return iv
  }()

  // 준비 중 라벨
  var readyLabel: UILabel = {
    let lb = UILabel()
    lb.text = " "
    lb.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
    lb.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    lb.setCharacterSpacing(-0.4)
    return lb
  }()

  // 스택뷰
  lazy var readyStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [readyImageView, readyLabel])
    sv.axis = .vertical
    sv.spacing = 4
    sv.alignment = .center
    sv.distribution = .fill
    return sv
  }()

  // MARK: - Init ⭐️
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)

    setupUI()

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Configure
  func configure(infoType: InfoType) {
    //        self.infoType = infoType

    switch infoType {
    case .discount:
      readyLabel.text = "이번 달 할인정보는 준비 중이에요"
    case .support:
      readyLabel.text = "이번 달 지원정보는 준비 중이에요"
    }
  }

  // MARK: - Set up UI
  private func setupUI() {
    self.backgroundColor = .clear
    self.addSubviews(readyStackView)

    setupConstraints()
  }

  // MARK: - Set up Constraints {
  private func setupConstraints() {
    readyImageView.snp.makeConstraints { make in
      make.height.equalTo(59)
      make.width.equalTo(63)
    }

    readyLabel.snp.makeConstraints { make in
      make.height.equalTo(20)
    }

    readyStackView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.height.equalTo(83)
      make.width.equalTo(203)
    }
  }
}
