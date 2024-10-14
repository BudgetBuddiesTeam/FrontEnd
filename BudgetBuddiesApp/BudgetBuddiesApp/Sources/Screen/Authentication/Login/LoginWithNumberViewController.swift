//
//  LoginWithNumberViewController.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/29/24.
//

import UIKit

class LoginWithNumberViewController: UIViewController {
    // MARK: - Properties
    let loginView = NumberAuthenticationView(.login)

    // MARK: - Life Cycle
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTextField()
        setupButtonActions()
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
    
    // MARK: - Set up Button Actions
    private func setupButtonActions() {
        self.loginView.sendAuthNumberButton.addTarget(self, action: #selector(didTapSendAuthNumberButton), for: .touchUpInside)
        self.loginView.completeAuthButton.addTarget(self, action: #selector(didTapCompleteAuthButton), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapSendAuthNumberButton() {
        self.loginView.addTextField()
    }
    
    @objc
    private func didTapCompleteAuthButton() {
        self.dismiss(animated: true, completion: nil)
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

