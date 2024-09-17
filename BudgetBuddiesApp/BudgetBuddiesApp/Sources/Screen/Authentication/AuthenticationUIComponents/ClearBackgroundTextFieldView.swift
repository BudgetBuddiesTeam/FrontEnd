//
//  ClearBackgroundTextFieldView.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/17/24.
//

import UIKit
import SnapKit

class ClearBackgroundTextFieldView: UIView {
    // MARK: - Properties
    enum TextFieldType: String {
        case phoneNumber = "휴대폰 번호 (-없이 숫자만 입력)"
        case AuthNumber = "인증번호 입력"
        case Name = "ex)김머니"
    }
    
    let textFieldType: TextFieldType
    
    // MARK: - UI Components
    let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = " "
        tf.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
        tf.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
        tf.setCharacterSpacing(-0.4)
        return tf
    }()
    
    // MARK: - Init
    init(textFieldType: TextFieldType) {
        self.textFieldType = textFieldType
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.textField.placeholder = textFieldType.rawValue
        
        // back View
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
        self.layer.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1).cgColor // 에셋 등록 필요
        self.layer.masksToBounds = true
        
        // textField
        self.addSubviews(textField)
        switch textFieldType {
        case .phoneNumber:
            self.textField.keyboardType = .numberPad
        case .AuthNumber:
            self.textField.keyboardType = .numberPad
        case .Name:
            self.textField.keyboardType = .default
        }
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
    }
}
