//
//  InfomationCell.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/26/24.
//

import Kingfisher
import SnapKit
import UIKit

protocol InformationCellDelegate: AnyObject {
  func didTapWebButton(in cell: InformationCell, urlString: String)
  func didTapLikesButton(in cell: InformationCell, likesCount: Int, infoType: InfoType, infoId: Int)
}

class InformationCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "InfomationCell"

  weak var delegate: InformationCellDelegate?

  var urlString: String = ""  // customDelegate로 넘겨줘야하기 때문에 따로 보관

  var infoType: InfoType?

  var infoId: Int?

  var likesCount: Int?
  // 전체보기 - 지원
  var support: SupportContent? {
    didSet {
      guard let support = support else { return }

      self.infoId = support.id
      self.infoTitleLabel.text = support.title
      self.dateLabel.text = support.dateRangeString
      self.urlString = support.siteURL

      if let url = URL(string: support.thumbnailURL) {
        self.logoImageView.kf.setImage(with: url)
      }

      self.likesLabel.text = String(support.likeCount)
      self.likesCount = support.likeCount
    }
  }

  // 전체보기 - 할인
  var discount: DiscountContent? {
    didSet {
      guard let discount = discount else { return }

      self.infoId = discount.id
      self.infoTitleLabel.text = discount.title
      self.dateLabel.text = discount.dateRangeString
      self.urlString = discount.siteURL

      if let discountRate = discount.discountRate {
        self.percentLabel.text = "~" + String(discountRate) + "%"
      }

      if let url = URL(string: discount.thumbnailURL) {
        self.logoImageView.kf.setImage(with: url)
      }

      self.likesLabel.text = String(discount.likeCount)
      self.likesCount = discount.likeCount
    }
  }

  // 캘린더 메인 페이지에서 받을 정보
  var recommend: InfoDtoList? {
    didSet {
      guard let recommend = recommend else { return }

      self.infoId = recommend.id
      self.infoTitleLabel.text = recommend.title
      self.dateLabel.text = recommend.dateRangeString
      self.urlString = recommend.siteURL

      if let discountRate = recommend.discountRate {
        self.percentLabel.text = "~" + String(discountRate) + "%"
      }

      if let url = URL(string: recommend.thumbnailURL) {
        self.logoImageView.kf.setImage(with: url)
      }

      self.likesLabel.text = String(recommend.likeCount)
      self.likesCount = recommend.likeCount
    }
  }

  // 댓글
  var commentCount: Int? {
    didSet {
      guard let commentCount = self.commentCount else { return }
      self.commentsLabel.text = String(commentCount)
    }
  }

  // MARK: - UI Components
  // 뒷 배경
  lazy var backView: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
    view.layer.cornerRadius = 15
    view.setShadow(opacity: 1, Radius: 10, offSet: CGSize(width: 0, height: 0))
    return view
  }()

  // 로고 이미지뷰
  var logoImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "logoTempImage")
    iv.contentMode = .scaleAspectFill
    iv.layer.masksToBounds = true
    iv.layer.cornerRadius = 15
    return iv
  }()

  // 타이틀 라벨
  var infoTitleLabel: UILabel = {
    let lb = UILabel()
    lb.text = "Loading..."
    lb.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 16)
    lb.setCharacterSpacing(-0.4)
    lb.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    lb.numberOfLines = 0
    return lb
  }()

  // (기간) 시계 아이콘 이미지
  var dateIconImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "clockIconImage")
    iv.contentMode = .scaleAspectFit
    return iv
  }()

  // (기간) 라벨
  var dateLabel: UILabel = {
    let lb = UILabel()
    lb.text = "00.00 ~ 00.00"
    lb.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 12)
    lb.setCharacterSpacing(-0.3)
    lb.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    lb.textAlignment = .left
    return lb
  }()

  // 기간 스택뷰
  lazy var dateStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [dateIconImageView, dateLabel])
    sv.axis = .horizontal
    sv.spacing = 4
    sv.alignment = .center
    sv.distribution = .fill
    return sv
  }()

  // (세일) 라벨 아이콘 이미지
  var percentIconImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "labelIconImage")
    iv.contentMode = .scaleAspectFit
    return iv
  }()

  var percentLabel: UILabel = {
    let lb = UILabel()
    lb.text = "~0%"
    lb.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 12)
    lb.setCharacterSpacing(-0.3)
    lb.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    lb.textAlignment = .left
    return lb
  }()

  lazy var percentStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [percentIconImageView, percentLabel])
    sv.axis = .horizontal
    sv.spacing = 4
    sv.alignment = .center
    sv.distribution = .fill
    return sv
  }()

  // MARK: - 전체 스택뷰
  lazy var verticalStackView: UIStackView = {
    let sv = UIStackView()
    sv.axis = .vertical
    sv.spacing = 2
    sv.alignment = .leading
    sv.distribution = .fill
    return sv
  }()

  // MARK: - 댓글, 좋아요
  // 댓글
  var commentsIconImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "commentsIconImage")
    iv.contentMode = .scaleAspectFit
    return iv
  }()

  var commentsLabel: UILabel = {
    let lb = UILabel()
    lb.text = "0"
    lb.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 14)
    lb.setCharacterSpacing(-0.35)
    lb.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    lb.textAlignment = .left
    return lb
  }()

  // 좋아요
  lazy var likesIconImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "heartIconImage")
    iv.contentMode = .scaleAspectFit

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLikesButton))
    iv.addGestureRecognizer(tapGesture)
    iv.isUserInteractionEnabled = true

    return iv
  }()

  var likesLabel: UILabel = {
    let lb = UILabel()
    lb.text = "0"  // 나중에 받을 거
    lb.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 14)
    lb.setCharacterSpacing(-0.35)
    lb.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
    lb.textAlignment = .left
    return lb
  }()

  // MARK: - 사이트 바로가기 버튼
  private lazy var webButton: UIButton = {
    let btn = UIButton()
    btn.setTitle("사이트 바로가기", for: .normal)
    btn.titleLabel?.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 14)
    btn.setCharacterSpacing(-0.35, for: .normal)
    btn.setTitleColor(BudgetBuddiesAppAsset.AppColor.white.color, for: .normal)
    btn.backgroundColor = BudgetBuddiesAppAsset.AppColor.coreYellow.color
    btn.layer.masksToBounds = true
    btn.layer.cornerRadius = 10

    btn.addTarget(self, action: #selector(didTapWebButton), for: .touchUpInside)

    return btn
  }()

  // MARK: - init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)

    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Configure
  func configure(infoType: InfoType) {
    self.infoType = infoType
    // 기존 arragedSubviews제거
    for view in verticalStackView.arrangedSubviews {
      verticalStackView.removeArrangedSubview(view)
      view.removeFromSuperview()
    }

    // 다시 추가
    switch infoType {
    case .discount:
      verticalStackView.addArrangedSubview(infoTitleLabel)
      verticalStackView.addArrangedSubview(dateStackView)
      verticalStackView.addArrangedSubview(percentStackView)

    case .support:
      verticalStackView.addArrangedSubview(infoTitleLabel)
      verticalStackView.addArrangedSubview(dateStackView)

    }
  }

  // MARK: - Set up UI
  private func setupUI() {
    self.backgroundColor = .clear
    self.contentView.addSubviews(backView, webButton)
    self.backView.addSubviews(
      logoImageView, verticalStackView, likesIconImageView, likesLabel, commentsLabel,
      commentsIconImageView)

    setupConstraints()
  }

  // MARK: - Set up Constraints
  private func setupConstraints() {
    backView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(6)
      make.leading.trailing.equalToSuperview().inset(16)
    }

    logoImageView.snp.makeConstraints { make in
      make.height.width.equalTo(65)
      make.top.leading.equalToSuperview().inset(16)
    }

    infoTitleLabel.snp.makeConstraints { make in
      //      make.height.equalTo(24)
    }

    dateIconImageView.snp.makeConstraints { make in
      make.width.height.equalTo(14)
    }

    dateLabel.snp.makeConstraints { make in
      make.height.equalTo(15)
    }

    percentIconImageView.snp.makeConstraints { make in
      make.width.height.equalTo(14)
    }

    percentLabel.snp.makeConstraints { make in
      make.height.equalTo(15)
    }

    verticalStackView.snp.makeConstraints { make in
      make.leading.equalTo(logoImageView.snp.trailing).offset(12)
      make.trailing.equalTo(commentsIconImageView.snp.leading).offset(-8)
      make.centerY.equalTo(logoImageView.snp.centerY)
    }

    likesLabel.snp.makeConstraints { make in
      make.trailing.top.equalToSuperview().inset(16)
      make.height.equalTo(21)
    }

    likesIconImageView.snp.makeConstraints { make in
      make.trailing.equalTo(likesLabel.snp.leading).offset(-2)
      make.top.equalToSuperview().inset(16)
      make.height.equalTo(20)
      make.width.equalTo(16)
    }

    commentsLabel.snp.makeConstraints { make in
      make.trailing.equalTo(likesIconImageView.snp.leading).offset(-8)
      make.top.equalToSuperview().inset(16)
      make.height.equalTo(21)
    }

    commentsIconImageView.snp.makeConstraints { make in
      make.trailing.equalTo(commentsLabel.snp.leading).offset(-4)  // 원래는 2, 디자이너분께 물어보기
      make.top.equalToSuperview().inset(20)
      make.height.width.equalTo(15)

    }

    webButton.snp.makeConstraints { make in
      make.leading.bottom.trailing.equalTo(backView).inset(16)
      make.height.equalTo(39)
    }
  }

  // MARK: - Selectors
  @objc
  private func didTapWebButton() {
    delegate?.didTapWebButton(in: self, urlString: urlString)
  }

  @objc
  private func didTapLikesButton() {
    guard let id = self.infoId,
      let infoType = self.infoType,
      let likesCount = self.likesCount
    else { return }

    delegate?.didTapLikesButton(in: self, likesCount: likesCount, infoType: infoType, infoId: id)
  }
}
