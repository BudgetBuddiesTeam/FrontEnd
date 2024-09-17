//
//  NumberAuthenticationViewController.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/15/24.
//

import UIKit

class NumberAuthenticationViewController: UIViewController {
    // MARK: - Properties
    let numberAuthenticationView = NumberAuthenticationView()
    
    // MARK: - Life Cycle
    override func loadView() {
        self.view = numberAuthenticationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupButtonActions()
        setupTextField()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Set up TextField
    private func setupTextField() {
        self.numberAuthenticationView.numberTextField.textField.delegate = self
        self.numberAuthenticationView.authNumberTextField.textField.delegate = self
    }
    
    // MARK: - Set up Navigation Bar
    private func setupNavigationBar() {
        addBackButton(selector: #selector (didTapBackButton))
    }
    
    // MARK: - Set up Button Actions
    private func setupButtonActions() {
        self.numberAuthenticationView.sendAuthNumberButton.addTarget(self, action: #selector(didTapSendAuthNumberButton), for: .touchUpInside)
        self.numberAuthenticationView.completeAuthButton.addTarget(self, action: #selector(didTapCompleteAuthButton), for: .touchUpInside)
    }
    
    // MARK: - Selecors
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapSendAuthNumberButton() {
        self.numberAuthenticationView.addTextField()
    }
    
    @objc
    private func didTapCompleteAuthButton() {
        let basicInformationVC = BasicInformationViewController()
        basicInformationVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(basicInformationVC, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension NumberAuthenticationViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // 휴대폰 번호 텍스트필드
        if textField == self.numberAuthenticationView.numberTextField.textField {
            // 텍스트 필드에 텍스트가 없으면 버튼 비활성화
            if let text = textField.text, text.isEmpty {
                self.numberAuthenticationView.sendAuthNumberButton.isButtonEnabled = false
            } else {
                self.numberAuthenticationView.sendAuthNumberButton.isButtonEnabled = true
            }
        }
        
        // 인증번호 텍스트필드
        if textField == self.numberAuthenticationView.authNumberTextField.textField {
            if let text = textField.text, text.isEmpty {
                self.numberAuthenticationView.completeAuthButton.isButtonEnabled = false
            } else {
                self.numberAuthenticationView.completeAuthButton.isButtonEnabled = true
            }
        }
    }
}
