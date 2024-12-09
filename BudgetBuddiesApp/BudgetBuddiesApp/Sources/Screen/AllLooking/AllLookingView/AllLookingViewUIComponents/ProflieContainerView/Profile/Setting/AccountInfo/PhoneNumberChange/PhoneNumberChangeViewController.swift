//
//  PhoneNumberChangeViewController.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 12/2/24.
//

import UIKit

class PhoneNumberChangeViewController: UIViewController {
    
    public lazy var phoneNumberChangeView = PhoneNumberChangeView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = phoneNumberChangeView
        setupNavigationBar()
        setupTextField()
        setupButtonActions()
    }
    
    
    // MARK: - Set up TextField
    private func setupTextField() {
        self.phoneNumberChangeView.numberTextField.textField.delegate = self
        self.phoneNumberChangeView.authNumberTextField.textField.delegate = self
    }
    
    // MARK: - Set up Navigation Bar
    private func setupNavigationBar() {
        navigationItem.title = "전화번호 변경"
        addBackButton(selector: #selector (didTapBackButton))
    }
    
    // MARK: - Set up Button Actions
    private func setupButtonActions() {
        self.phoneNumberChangeView.sendAuthNumberButton.addTarget(self, action: #selector(didTapSendAuthNumberButton), for: .touchUpInside)
        self.phoneNumberChangeView.completeAuthButton.addTarget(self, action: #selector(didTapCompleteAuthButton), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapSendAuthNumberButton() {
        self.phoneNumberChangeView.addTextField()
    }
    
    @objc
    private func didTapCompleteAuthButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UITextFieldDelegate
extension PhoneNumberChangeViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // 휴대폰 번호 텍스트필드
        if textField == self.phoneNumberChangeView.numberTextField.textField {
            // 텍스트 필드에 텍스트가 없으면 버튼 비활성화
            if let text = textField.text, text.isEmpty {
                self.phoneNumberChangeView.sendAuthNumberButton.isButtonEnabled = false
            } else {
                self.phoneNumberChangeView.sendAuthNumberButton.isButtonEnabled = true
            }
        }
        
        // 인증번호 텍스트필드
        if textField == self.phoneNumberChangeView.authNumberTextField.textField {
            if let text = textField.text, text.isEmpty {
                self.phoneNumberChangeView.completeAuthButton.isButtonEnabled = false
            } else {
                self.phoneNumberChangeView.completeAuthButton.isButtonEnabled = true
            }
        }
    }
}

