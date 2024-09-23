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
    
    // 이름 작성되었는지 확인하는 변수
    var isNameFilled: Bool = false
    var isGenderSelected: Bool = false
    var isAgeSelected: Bool = false

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
        self.isGenderSelected = true
        basicInformationView.genderRadioButtonToggle(sender)
    }
    
    @objc
    private func didTapAgeRadioButton(sender: ClearBackgroundRadioButton) {
        self.isAgeSelected = true
        basicInformationView.ageRadioButtonToggle(sender)
    }
    
    @objc
    private func didTapKeepGoingButton() {
        if isNameFilled && isGenderSelected && isAgeSelected { // 모두 작성, 선택되어야 pushViewController실행
            print(#function)
            
        } else if !isNameFilled { // 이름이 작성되지 않았을 경우
            print("이름 작성x")
            self.basicInformationView.notWrittenPopUpView.popUp(with: .name)
            
        } else if !isGenderSelected { // 성별이 선택되지 않았을 경우
            print("성별 선택x")
            self.basicInformationView.notWrittenPopUpView.popUp(with: .gender)
            
        } else { // 나이가 선택되지 않았을 경우
            print("나이 선택x")
            self.basicInformationView.notWrittenPopUpView.popUp(with: .age)
        }
    }
}

// MARK: - UITextField Delegate
extension BasicInformationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // textField 작성이 끝났을 때 빈칸인지 아닌지 판단
        if let currentText = textField.text {
            print("작성된 이름: \(currentText)")
            
            if currentText.isEmpty {
                self.isNameFilled = false
                
            } else {
                self.isNameFilled = true
            }
        }
    }
}
