//
//  BasicInformationViewController.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/18/24.
//

import UIKit

class BasicInformationViewController: UIViewController {
    // MARK: - Properties
    let basicInformationView = BasicInformationView()

    // MARK: - Life Cycle
    override func loadView() {
        self.view = basicInformationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTextField()
        setupKeyboardDismiss()
    }
    
    // MARK: - Set up KeyBoardDismiss
    // 스크롤뷰가 이벤트를 가로채서, 이렇게 따로 선언
    private func setupKeyboardDismiss() {
        self.basicInformationView.scrollView.keyboardDismissMode = .onDrag
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didScrollViewTapped))
        tapGesture.cancelsTouchesInView = false
        basicInformationView.contentView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Set up TextField
    private func setupTextField() {
        self.basicInformationView.nameTextField.textField.delegate = self
    }
    
    // MARK: - Set up NavigationBar
    private func setupNavigationBar() {
        setupDefaultNavigationBar(backgroundColor: BudgetBuddiesAppAsset.AppColor.white.color)
        addBackButton(selector: #selector (didTapBackButton))
    }
    
    // MARK: - Selectors
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didScrollViewTapped() {
        self.view.endEditing(true)
    }
}

// MARK: - UITextField Delegate
extension BasicInformationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("dhfaluioh")
        self.view.endEditing(true)
        return true
    }
}
