//
//  ConsumedAnalysisSecondItem.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/9/24.
//

import UIKit

class MonthlyConsumedAnalysisSecondItem: UIView {

  // MARK: - Properties
  // mainView에서 userName을 전달받으면 이름 설정 함수 실행
  var userName: String? {
    didSet {
      setUserName()
    }
  }

  // MARK: - UI Componenets

  // 텍스트 레이블
  private let textLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.text = "혜인님 또래는\n이번 주 패션에 5만원 사용했어요"
    label.font = BudgetBuddiesAppFontFamily.Pretendard.medium.font(size: 16)
    label.setLineSpacing(lineSpacing: 10)
    return label
  }()

  // 아이콘 이미지뷰
  private let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = BudgetBuddiesAppAsset.AppImage.MainViewImage.chartIcon.image
    return imageView
  }()

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)

    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  private func setUserName() {
    guard let userName = self.userName else { return }
    self.textLabel.text = "\(userName)님 또래는\n이번 주 패션에 5만원 사용했어요"
  }

  private func setLayout() {
    self.setShadow(opacity: 1, Radius: 5, offSet: CGSize(width: 0, height: 0))
    backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
    layer.cornerRadius = 15

    self.snp.makeConstraints { make in
      make.height.equalTo(88)
    }

    addSubviews(
      textLabel,
      iconImageView)

    textLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.centerY.equalToSuperview()
    }

    iconImageView.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(21)
      make.centerY.equalToSuperview()
    }
  }
}
