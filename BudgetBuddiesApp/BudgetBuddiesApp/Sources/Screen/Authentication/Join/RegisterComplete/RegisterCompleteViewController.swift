//
//  RegisterCompleteViewController.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/26/24.
//

import UIKit

class RegisterCompleteViewController: UIViewController {
    // MARK: - Properties
    let registerCompleteView = RegisterCompleteView()

    // MARK: - Life Cycle
    override func loadView() {
        self.view = registerCompleteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtonActions()
        setupNavigationBar()
    }
    
    // MARK: - Set up Button Actions
    private func setupButtonActions() {
        registerCompleteView.startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
    }
    
    // MARK: - Set up Navigation Bar
    private func setupNavigationBar() {
        setupDefaultNavigationBar(backgroundColor: BudgetBuddiesAppAsset.AppColor.white.color)
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: - Selector
    @objc
    private func didTapStartButton() {
        dismiss(animated: true)
    }
}
