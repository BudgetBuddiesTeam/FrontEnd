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
        setupButtonActions()
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
    
    // MARK: - Set up Button Actions
    private func setupButtonActions() {
        // 성별 버튼
        basicInformationView.maleButton.addTarget(self, action: #selector(didTapGenderButton), for: .touchUpInside)
        basicInformationView.femaleButton.addTarget(self, action: #selector(didTapGenderButton), for: .touchUpInside)
        
        // 나이 버튼
        basicInformationView.ageButtonArray.forEach { $0.addTarget(self, action: #selector(didTapAgeRadioButton), for: .touchUpInside) }
        
        // 계속하기 버튼
        basicInformationView.keepGoingButton.addTarget(self, action: #selector(didTapKeepGoingButton), for: .touchUpInside)
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
    
    @objc
    private func didTapGenderButton(sender: ClearBackgroundRadioButton) {
        basicInformationView.genderRadioButtonToggle(sender)
    }
    
    @objc
    private func didTapAgeRadioButton(sender: ClearBackgroundRadioButton) {
        basicInformationView.ageRadioButtonToggle(sender)
    }
    
    @objc
    private func didTapKeepGoingButton() {
        print(#function)
        /*
         해야할 일
         버튼을 눌렀을 때 이름, 성별, 연력을 선택하지 않았을 경우 알람창 뜨게
         */
    }
}

// MARK: - UITextField Delegate
extension BasicInformationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
