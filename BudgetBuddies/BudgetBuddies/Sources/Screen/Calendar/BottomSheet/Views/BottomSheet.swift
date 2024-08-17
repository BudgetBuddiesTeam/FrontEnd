//
//  BottomSheet.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/27/24.
//

import SnapKit
import UIKit

class BottomSheet: UIView {
  // MARK: - Properties
  private let maxLines: Int = 4

    
  // MARK: - UI Components
  // 뒷 배경
  lazy var backView: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    view.layer.masksToBounds = true
    view.layer.cornerRadius = 24
    view.layer.maskedCorners = CACornerMask(
      arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    return view
  }()

  // topRectView
  var topRectView: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.circleStroke.color
    view.layer.masksToBounds = true
    view.layer.cornerRadius = 2
    return view
  }()

  // "댓글"라벨
  var commentsLabel: UILabel = {
    let lb = UILabel()
    lb.text = "댓글"
    lb.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 22)
    lb.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    lb.setCharacterSpacing(-0.55)
    return lb
  }()

  // 구분선
  var topSeparator: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.circleStroke.color
    return view
  }()

  // 댓글 tableView
  lazy var commentsTableView = UITableView()

  // 텍스트필드 뒷배경
  var textViewBackView: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    return view
  }()

  var textViewSeparator: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.circleStroke.color
    return view
  }()

  var textBox: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.textBox.color
    view.layer.masksToBounds = true
    view.layer.cornerRadius = 10
    return view
  }()

  lazy var sendButton: UIButton = {
    let btn = UIButton()
    btn.setImage(UIImage(named: "sendButtonImage"), for: .normal)
    return btn
  }()

  // lazy var 필수
  lazy var commentTextView: UITextView = {
    let tv = UITextView()
    tv.backgroundColor = .clear
    tv.text = " "
    tv.textColor = BudgetBuddiesAsset.AppColor.textExample.color

    tv.font = BudgetBuddiesFontFamily.Pretendard.regular.font(size: 14)
    tv.setCharacterSpacing(-0.35)

    tv.showsVerticalScrollIndicator = false
    tv.showsHorizontalScrollIndicator = false

    tv.autocapitalizationType = .none
    tv.autocorrectionType = .no
    tv.spellCheckingType = .no

    return tv
  }()

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)

    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Set up UI
  private func setupUI() {
    self.addSubviews(backView)

    backView.addSubviews(
      topRectView, commentsLabel, topSeparator, commentsTableView, textViewBackView)
    textViewBackView.addSubviews(textViewSeparator, textBox)
    textBox.addSubviews(sendButton, commentTextView)

    setupConstraints()
  }

  // MARK: - Set up Constraints
  private func setupConstraints() {
    backView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    topRectView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(15)
      make.centerX.equalToSuperview()
      make.width.equalTo(71)
      make.height.equalTo(4)
    }

    commentsLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(44)
      make.leading.equalToSuperview().inset(22)
      make.height.equalTo(28)
      make.width.equalTo(38)
    }

    topSeparator.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalToSuperview().inset(89)
      make.height.equalTo(2)
    }

    commentsTableView.snp.makeConstraints { make in
      make.top.equalTo(topSeparator.snp.bottom)
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(textViewSeparator.snp.top)
    }

    textViewBackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(self.layoutMarginsGuide.snp.bottom)
      //      make.height.equalTo(85)
      make.top.equalTo(textBox.snp.top).inset(-14)
    }

    textViewSeparator.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(1)
    }

    textBox.snp.makeConstraints { make in
      //          make.top.equalToSuperview().inset(20)
      make.top.equalTo(commentTextView).offset(-9.5)
      make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(30)
      make.leading.trailing.equalToSuperview().inset(16)
      //          make.height.equalTo(52)
    }

    sendButton.snp.makeConstraints { make in
      make.trailing.bottom.equalToSuperview().inset(12)
      make.height.width.equalTo(28)
    }

    commentTextView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(9.5)
      make.bottom.equalToSuperview().inset(9.5)
      make.leading.equalToSuperview().inset(21)
      make.trailing.equalTo(sendButton.snp.leading).inset(-12)
      make.height.equalTo(33)
    }
  }

  // MARK: - Functions
  func updateTextViewHeight() {
    guard let font = commentTextView.font else { return }

    let textViewWidth = commentTextView.bounds.width
    let lineHeight = font.lineHeight

    // 현재 텍스트에 필요한 높이 계산
    let textHeight = commentTextView.sizeThatFits(CGSize(width: textViewWidth, height: .infinity))
      .height

    // 최대 텍스트 뷰 높이 계산 (maxLines 속성을 기준으로)
    let maxTextViewHeight = lineHeight * CGFloat(maxLines)
    let newHeight: CGFloat

    if textHeight <= maxTextViewHeight {
      // 텍스트 높이가 최대 높이 이하일 경우
      newHeight = textHeight
      commentTextView.isScrollEnabled = false
    } else {
      // 텍스트 높이가 최대 높이를 초과할 경우
      newHeight = maxTextViewHeight
      commentTextView.isScrollEnabled = true
    }

    // 제약 조건 적용 전 레이아웃을 업데이트하여 반영
    self.layoutIfNeeded()

    // commentTextView의 제약 조건 업데이트
    commentTextView.snp.updateConstraints { make in
      make.height.equalTo(newHeight)
    }

    // 레이아웃 변경을 애니메이션으로 부드럽게 조정
    UIView.animate(withDuration: 0.3) {
      self.layoutIfNeeded()
    }
  }
}
