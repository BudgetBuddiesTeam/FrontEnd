//
//  LoginWithNumberViewController.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/29/24.
//

import UIKit

class LoginWithNumberViewController: UIViewController {
    // MARK: - Properties
    let loginView = NumberAuthenticationView()

    // MARK: - Life Cycle
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTextField()
    }
    
    // MARK: - Set up TextField
    private func setupTextField() {
        self.loginView.numberTextField.textField.delegate = self
        self.loginView.authNumberTextField.textField.delegate = self
    }
    
    // MARK: - Set up Navigation Bar
    private func setupNavigationBar() {
        addBackButton(selector: #selector (didTapBackButton))
    }
    
    // MARK: - Selectors
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension LoginWithNumberViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // 휴대폰 번호 텍스트필드
        if textField == self.loginView.numberTextField.textField {
            // 텍스트 필드에 텍스트가 없으면 버튼 비활성화
            if let text = textField.text, text.isEmpty {
                self.loginView.sendAuthNumberButton.isButtonEnabled = false
            } else {
                self.loginView.sendAuthNumberButton.isButtonEnabled = true
            }
        }
        
        // 인증번호 텍스트필드
        if textField == self.loginView.authNumberTextField.textField {
            if let text = textField.text, text.isEmpty {
                self.loginView.completeAuthButton.isButtonEnabled = false
            } else {
                self.loginView.completeAuthButton.isButtonEnabled = true
            }
        }
    }
}

