//
//  MonthlyBudgetInfoCollectionViewCell.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/6/24.
//

import Kingfisher
import SnapKit
import UIKit

enum InfoCategoryType {
  case discount
  case support
}

// 커스텀 델리게이트를 통한 전체보기
protocol MonthlyBudgetInfoCollectionViewCellDelegate: AnyObject {
  /// 주머니 정보 셀이 터치 되었을 때 시점을 전달하는 함수입니다.
  /// 시점과 함께 정보의 타입(할인 또는 지원)도 전달합니다.
  /// - Parameters:
  ///   - cell: 터치 시점을 전달하는 셀입니다.
  ///   - infoType: 터치된 셀의 정보 타입입니다.
  func didTapInfoCell(in cell: MonthlyBudgetInfoCollectionViewCell, infoType: InfoType)
}

class MonthlyBudgetInfoCollectionViewCell: UICollectionViewCell {
  // MARK: - Properties

  static let reuseIdentifier = "MonthlyBudgetInfo"

  var infoType: InfoType?
  weak var delegate: MonthlyBudgetInfoCollectionViewCellDelegate?

  // MARK: - UI Components

  // 최하단 backVIew
  public let whiteBackView: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
    view.layer.cornerRadius = 15
    view.setShadow(opacity: 1, Radius: 5, offSet: CGSize(width: 0, height: 0))
    return view
  }()

  // 정보 구분 배경색
  public let colorBackground: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 15
    view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

    // Dummy Color Data
    view.backgroundColor = BudgetBuddiesAppAsset.AppColor.lemon3.color
    return view
  }()

  // "~정보" 배경
  public let infoCategoryBackground: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 8
    view.snp.makeConstraints { make in
      make.width.equalTo(50)
      make.height.equalTo(19)
    }

    // Dummy Color Data
    view.backgroundColor = .clear
    return view
  }()

  // "~정보" 텍스트 레이블
  public var infoCategoryTextLabel: UILabel = {
    let label = UILabel()
    label.font = BudgetBuddiesAppFontFamily.Pretendard.medium.font(size: 12)

    // Dummy Text Data
    label.text = "더미정보"

    // Dummy Text Color Data
    label.textColor = .clear
    return label
  }()

  // 정보 텍스트 레이블
  public var titleTextLabel: UILabel = {
    let label = UILabel()
    label.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 16)
    label.snp.makeConstraints { make in
      make.width.equalTo(60)
    }
    label.numberOfLines = 2
    label.lineBreakMode = .byTruncatingTail

    // Dummy Text Data
    label.text = "더미제목"
    return label
  }()

  // 정보 아이콘 이미지뷰
  public var iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 12
    imageView.clipsToBounds = true
    imageView.snp.makeConstraints { make in
      make.width.height.equalTo(36)
    }
    return imageView
  }()

  // 정보 날짜 텍스트 레이블
  public lazy var dateTextLabel: DateTextLabel = {
    let label = DateTextLabel()
    label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 12)
    label.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    label.text = "00.00 - 00.00"
    return label
  }()

  // MARK: - Intializer

  override init(frame: CGRect) {
    super.init(frame: frame)

    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods

  public func configure(
    infoCategoryType: InfoCategoryType,
    titleText: String,
    iconImageURL: String,
    startDate: String,
    enddDate: String
  ) {

    switch infoCategoryType {
    case .discount:
      self.infoType = .discount
      self.infoCategoryTextLabel.text = "할인정보"
      self.infoCategoryTextLabel.textColor = BudgetBuddiesAppAsset.AppColor.orange2.color
      self.colorBackground.backgroundColor = BudgetBuddiesAppAsset.AppColor.lemon3.color
      self.infoCategoryBackground.backgroundColor = BudgetBuddiesAppAsset.AppColor.lemon2.color
    case .support:
      self.infoType = .support
      self.infoCategoryTextLabel.text = "지원정보"
      self.infoCategoryTextLabel.textColor = BudgetBuddiesAppAsset.AppColor.coreBlue.color
      self.colorBackground.backgroundColor = BudgetBuddiesAppAsset.AppColor.sky3.color
      self.infoCategoryBackground.backgroundColor = BudgetBuddiesAppAsset.AppColor.sky4.color
    }

    self.titleTextLabel.text = titleText
    self.iconImageView.kf.setImage(with: URL(string: iconImageURL))
    self.dateTextLabel.updateText(startDate: startDate, endDate: enddDate)

    // cell의 configure함수 이후에 self.infoType이 정해지기 때문에 이 부분에서 gesture 등록
    setupGesture()
  }

  private func setLayout() {
    layer.cornerRadius = 15
    backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color

    // Add Subviews

    addSubviews(whiteBackView)

    whiteBackView.addSubviews(
      colorBackground,
      infoCategoryBackground,
      titleTextLabel,
      iconImageView,
      dateTextLabel
    )

    infoCategoryBackground.addSubview(infoCategoryTextLabel)

    // Make UI Components Contraints
    // 최하단 백뷰
    whiteBackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    // 정보 구분 배경색
    colorBackground.snp.makeConstraints { make in
      make.height.equalTo(47)
      make.top.equalToSuperview()
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
    }

    // "~정보" 배경
    titleTextLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(12)
      make.top.equalToSuperview().inset(62)
    }

    // "~정보" 배경
    infoCategoryBackground.snp.makeConstraints { make in
      make.leading.top.equalToSuperview().inset(8)
    }

    // "~정보" 텍스트 레이블
    infoCategoryTextLabel.snp.makeConstraints { make in
      make.centerX.centerY.equalToSuperview()
    }

    // 정보 아이콘 이미지뷰
    iconImageView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(28)
      make.trailing.equalToSuperview().inset(8)
    }

    // 정보 날짜 텍스트 레이블
    dateTextLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(12)
      make.top.equalToSuperview().inset(129)
    }
  }

  // MARK: - Set up Gesture
  private func setupGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapInfoCell))
    self.contentView.addGestureRecognizer(tapGesture)
    self.contentView.isUserInteractionEnabled = true
  }

  // MARK: - Selectors
  @objc
  private func didTapInfoCell() {
    guard let infoType = self.infoType else { return }

    // 셀이 터치 되었을 때 대리자에게 처리할 일 넘기기
    delegate?.didTapInfoCell(in: self, infoType: infoType)
  }
}
