//
//  NumberAuthenticationView.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/17/24.
//

import UIKit
import SnapKit

class NumberAuthenticationView: UIView {
    // MARK: - UI Components
    let stepDot = StepDotView(steps: .firstStep)
    
    // 안녕하세요! 휴대폰 번호로 가입해주세요
    let bigTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "안녕하세요!\n휴대폰 번호로 가입해주세요"
        lb.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
        lb.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 24)
        lb.numberOfLines = 0
        lb.textAlignment = .left
        lb.setCharacterAndLineSpacing(characterSpacing: -0.6, lineSpacing: 0.0, lineHeightMultiple: 1.26)
        return lb
    }()
    
    let subTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "휴대폰 번호는 안전하게 보관돼요"
        lb.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
        lb.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 14)
        lb.setCharacterSpacing(-0.35)
        return lb
    }()
    
    lazy var titleStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [bigTitleLabel, subTitleLabel])
        sv.axis = .vertical
        sv.spacing = 9
        sv.alignment = .leading
        sv.distribution = .fill
        return sv
    }()
    
    // 휴대폰 번호
    let numberLabel: UILabel = {
        let lb = UILabel()
        lb.text = "휴대폰 번호"
        lb.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 14)
        lb.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
        lb.setCharacterSpacing(-0.35)
        lb.textAlignment = .left
        return lb
    }()
    
    // 번호 입력 텍스트필드
    let numberTextField = ClearBackgroundTextFieldView(textFieldType: .phoneNumber)
    
    let sendAuthNumberButton = ClearBackgroundButton()
    
    lazy var textFieldStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [numberTextField, sendAuthNumberButton])
        sv.axis = .vertical
        sv.spacing = 12
        sv.alignment = .center
        sv.distribution = .fill
        return sv
    }()
    
    // 문제가 있으신가요? 이메일로 계정찾기
    let problemLabel = SubLabel(grayText: "문제가 있으신가요?", yellowText: "이메일로 계정찾기", isLined: true)
    
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
        self.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
        
        self.addSubviews(stepDot, titleStackView, numberLabel, textFieldStackView, problemLabel)
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        let bigTitleHeight = 72 + 1 // 여유값 + 1
        let subTitleHeight = 21
        let titleStackHeight = bigTitleHeight + subTitleHeight + 9
        
        stepDot.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(32)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(8)
        }
        
        bigTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(bigTitleHeight)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(subTitleHeight)
        }
        
        titleStackView.snp.makeConstraints { make in
            make.height.equalTo(titleStackHeight)
            make.top.equalTo(stepDot.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        numberLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(titleStackView.snp.bottom).offset(32)
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
            make.top.equalTo(numberLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(52 + 52 + 12)
        }
        
        problemLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldStackView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
//            make.leading.trailing.equalToSuperview()
        }
    }
}
