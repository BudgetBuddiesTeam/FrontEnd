//
//  StartViewController.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/16/24.
//

import UIKit

final class StartViewController: UIViewController {
    // MARK: - Properties
    let startView = StartView()
    
    
    // MARK: - Life Cycle
    override func loadView() {
        self.view = startView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonAction()
    }
    
    // MARK: - Set Button Action
    private func setButtonAction() {
        startView.tempButton.addTarget(self, action: #selector(didTapTempButton), for: .touchUpInside)
        
        startView.nextButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        
        startView.alreadyHaveLabel.isUserInteractionEnabled = true
        startView.alreadyHaveLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapLoginLabel)))
    }
    
    // MARK: - Selectors
    @objc
    private func didTapStartButton() {
        let numberAuthenticationVC = JoinWithNumberViewController()
        self.navigationController?.pushViewController(numberAuthenticationVC, animated: true)
        
    }
    
    @objc
    private func didTapTempButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func didTapLoginLabel() {
        let loginVC = LoginWithNumberViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}
