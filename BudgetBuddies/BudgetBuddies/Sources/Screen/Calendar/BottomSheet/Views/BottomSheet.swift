//
//  BottomSheet.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/27/24.
//

import SnapKit
import UIKit

class BottomSheet: UIView {
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

  // 텍스트필드 뒷배경
  var textFieldBackView: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.white.color
    return view
  }()

  var textFieldSeparator: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.circleStroke.color
    return view
  }()

  lazy var textField: UITextField = {
    let tf = UITextField()
    tf.backgroundColor = BudgetBuddiesAsset.AppColor.textBox.color
    tf.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    tf.placeholder = "댓글을 입력해주세요"
    tf.borderStyle = .none
    tf.layer.masksToBounds = true
    tf.layer.cornerRadius = 10
    //        tf.clearButtonMode = .always // 텍스트필드에 전체 지우기 버튼 생성

    tf.autocapitalizationType = .none  // 첫 글자 자동 대문자
    tf.autocorrectionType = .no  // 추천 글자를 보여줄지
    tf.spellCheckingType = .no  // 오류난 글자를 고쳐줄지
    tf.clearsOnBeginEditing = false  // 편집시 기존 텍스트필드 값 제거

    tf.setCharacterSpacing(-0.35)
    tf.font = BudgetBuddiesFontFamily.Pretendard.regular.font(size: 14)

    // 왼쪽에 빈 공간
    let leftSpacer = UIView()
    leftSpacer.frame = CGRect(x: 0, y: 0, width: 21, height: 21)
    tf.leftView = leftSpacer
    tf.leftViewMode = .always

    // 오른쪽에 빈 공간
    let rightSpacer = UIView()
    rightSpacer.frame = CGRect(x: 0, y: 0, width: 28 + 12, height: 28)

    // 전송 버튼
    let sendButton = UIButton(type: .custom)
    sendButton.setImage(UIImage(named: "sendButtonImage"), for: .normal)
    sendButton.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
      self.sendButton = sendButton

    sendButton.frame.origin = CGPoint(x: 0, y: 0)
    rightSpacer.addSubview(sendButton)

    tf.rightView = rightSpacer
    tf.rightViewMode = .always

    return tf
  }()
    
    // 전송버튼 외부에서 접근 가능
    private(set) var sendButton: UIButton?

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
    backView.addSubviews(topRectView, commentsLabel, topSeparator, textFieldBackView)
    textFieldBackView.addSubviews(textFieldSeparator, textField)

    setupConstraints()
  }

  // MARK: - Set up Constraints
  private func setupConstraints() {
    backView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    topRectView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(14)
      make.centerX.equalToSuperview()
      make.width.equalTo(70)
      make.height.equalTo(4)
    }

    commentsLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(50)
      make.leading.equalToSuperview().inset(38)
      make.height.equalTo(28)
      make.width.equalTo(38)
    }

    topSeparator.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalToSuperview().inset(104)
      make.height.equalTo(2)
    }

    textFieldBackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(self.layoutMarginsGuide.snp.bottom)
      make.height.equalTo(85)
    }

    textFieldSeparator.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(1)
    }

    textField.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(20)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(52)
    }
  }
}
