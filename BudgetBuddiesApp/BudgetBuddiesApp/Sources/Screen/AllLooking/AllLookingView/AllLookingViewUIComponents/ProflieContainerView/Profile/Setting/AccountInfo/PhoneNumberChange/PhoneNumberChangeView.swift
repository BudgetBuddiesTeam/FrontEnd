//
//  PhoneNumberChangeView.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 12/2/24.
//

import SnapKit
import UIKit

class PhoneNumberChangeView: UIView {
  // MARK: - Properties

  var isTextFieldAdded: Bool = false {
    didSet {
      if isTextFieldAdded {
        self.sendAuthNumberButton.setTitle("재전송", for: .normal)
      }
    }
  }

  var timer: Timer?

  // MARK: - UI Components

  // 변경할 전화번호를 입력해주세요
  let bigTitleLabel: UILabel = {
    let lb = UILabel()
    lb.text = "변경할 전화번호를\n입력해주세요"
    lb.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
    lb.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 24)
    lb.numberOfLines = 0
    lb.textAlignment = .left
    lb.setCharacterAndLineSpacing(
      characterSpacing: -0.6, lineSpacing: 0.0, lineHeightMultiple: 1.26)
    return lb
  }()

  // 번호 입력 텍스트필드
  let numberTextField = ClearBackgroundTextFieldView(textFieldType: .phoneNumber)

  lazy var authNumberTextField = ClearBackgroundTextFieldView(textFieldType: .AuthNumber)

  let sendAuthNumberButton: SendAuthNumberButton = {
    let btn = SendAuthNumberButton()
    btn.setTitle("인증문자 받기", for: .normal)
    return btn
  }()

  lazy var textFieldStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [numberTextField, sendAuthNumberButton])
    sv.axis = .vertical
    sv.spacing = 12
    sv.alignment = .center
    sv.distribution = .fill
    return sv
  }()

  // 인증 완료 버튼
  lazy var completeAuthButton: YellowRectangleButton = {
    let btn = YellowRectangleButton(.save, isButtonEnabled: false)
    btn.alpha = 0
    return btn
  }()

  let timerLabel: UILabel = {
    let lb = UILabel()
    lb.text = " "
    lb.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
    lb.textColor = UIColor(red: 0.72, green: 0.72, blue: 0.72, alpha: 1)
    lb.textAlignment = .right
    lb.setCharacterSpacing(-0.4)
    return lb
  }()

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)

    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Add TextField
  func addTextField() {
    if !isTextFieldAdded {
      // 인증번호 입력 칸을 추가하되, 처음에는 불투명도로 설정
      self.authNumberTextField.alpha = 0
      self.textFieldStackView.insertArrangedSubview(self.authNumberTextField, at: 1)

      // 중간에 빈 공간 추가
      let tempView = UIView()
      tempView.frame.size.height = 12
      self.textFieldStackView.addArrangedSubview(tempView)

      // 다시 버튼 추가
      self.textFieldStackView.addArrangedSubview(self.sendAuthNumberButton)

      // 제약조건 추가
      self.authNumberTextField.snp.makeConstraints { make in
        make.height.equalTo(52)
        make.width.equalTo(self.textFieldStackView.snp.width)
      }

      self.sendAuthNumberButton.snp.makeConstraints { make in
        make.height.equalTo(52)
        make.width.equalTo(self.textFieldStackView.snp.width)
      }

      self.authNumberTextField.addSubviews(timerLabel)
      timerLabel.snp.makeConstraints { make in
        make.trailing.equalToSuperview().inset(16)
        make.centerY.equalToSuperview()
        make.height.equalTo(20)
      }

      setTimer()

      // 인증번호 입력 칸의 불투명도 애니메이션
      UIView.animate(
        withDuration: 0.4,
        animations: {
          self.completeAuthButton.alpha = 1
          self.layoutIfNeeded()
        }
      ) { _ in
        // 첫 번째 애니메이션 완료 후 두 번째 애니메이션 실행
        UIView.animate(withDuration: 0.2) {
          self.authNumberTextField.alpha = 1
        }
      }

      self.isTextFieldAdded = true
    } else {
      setTimer()
    }
  }

  // MARK: - Add Timer
  func setTimer() {

    timer?.invalidate()  // 타이머가 이미 있으면 삭제
    var remainingTime: Int = 300  // 5분 (300초)
    timerLabel.text = "5:00"

    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
      if remainingTime > 0 {
        remainingTime -= 1

        let minutes = remainingTime / 60
        let seconds = remainingTime % 60

        self.timerLabel.text = String(format: "%d:%02d", minutes, seconds)
      } else {
        timer.invalidate()
        self.timerLabel.text = "0:00"
      }
    }
  }

  // MARK: - Set up UI
  private func setupUI() {
    self.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color

    [bigTitleLabel, timerLabel, textFieldStackView, completeAuthButton].forEach {
      self.addSubview($0)
    }

    setupConstraints()
  }

  // MARK: - Set up Constraints
  private func setupConstraints() {
    bigTitleLabel.snp.makeConstraints { make in
      //            make.height.equalTo(72)
      make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(32)
      make.leading.trailing.equalToSuperview().inset(16)
    }

    numberTextField.snp.makeConstraints { make in
      make.height.equalTo(52)
      make.width.equalTo(textFieldStackView.snp.width)
    }

    sendAuthNumberButton.snp.makeConstraints { make in
      make.height.equalTo(52)
      make.width.equalTo(textFieldStackView.snp.width)
    }

    textFieldStackView.snp.makeConstraints { make in
      make.top.equalTo(bigTitleLabel.snp.bottom).offset(31)
      make.leading.trailing.equalToSuperview().inset(16)
    }

    completeAuthButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(54)
      make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
    }
  }
}
