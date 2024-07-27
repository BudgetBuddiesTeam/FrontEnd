//
//  BottomSheetViewController.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/27/24.
//

import UIKit
import SnapKit

final class BottomSheetViewController: DimmedViewController {
    // MARK: - Properties
    private let bottomSheet = BottomSheet()
    
    private var bottomSheetTopConstraint: Constraint?
    private var bottomSheetBottomConstraint: Constraint?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTapGesture()
        setupTextField()
        registerKeyboardNotifications()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Set up TextField {
    private func setupTextField() {
        bottomSheet.textField.delegate = self
        
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.view.addSubview(bottomSheet)
        
        setupConstraint()
    }
    
    // MARK: - Set up Constraints {
    private func setupConstraint() {
        bottomSheet.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            bottomSheetTopConstraint = make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(300).constraint
            bottomSheetBottomConstraint = make.bottom.equalTo(view.snp.bottom).inset(0).constraint
        }
    }
    
    // MARK: - Set up View TapGesture
    private func setupTapGesture() {
        self.view.isUserInteractionEnabled = true
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(viewTapGesture)
        
        // 뒷 배경만을 눌렀을 경우에 dismiss가 되도록
        // bottomSheet에 temp gesture 설정
        // 다른 방법이 있다면 추후에 수정할 예정
        bottomSheet.isUserInteractionEnabled = true
        let tempTapGesture = UITapGestureRecognizer(target: self, action: nil)
        bottomSheet.addGestureRecognizer(tempTapGesture)
    }
    
    // MARK: - register Keyboard Notification
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Selectors
    @objc
    private func didTapView() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        UIView.animate(withDuration: 0.3) {
            self.bottomSheetBottomConstraint?.update(offset: -keyboardHeight)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.bottomSheetBottomConstraint?.update(offset: 0) // 원래 위치로 복원
            self.view.layoutIfNeeded()
        }
    }
        
}

extension BottomSheetViewController: UITextFieldDelegate {
    // 입력 시작
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("입력 시작")
        UIView.animate(withDuration: 0.3) {
            self.bottomSheetTopConstraint?.update(offset: 0)
            self.view.layoutIfNeeded()
        }
    }
    
    // 입력 끝
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("입력 끝")
        UIView.animate(withDuration: 0.3) {
            self.bottomSheetTopConstraint?.update(inset: 300)
            self.view.layoutIfNeeded()
        }
    }
}
