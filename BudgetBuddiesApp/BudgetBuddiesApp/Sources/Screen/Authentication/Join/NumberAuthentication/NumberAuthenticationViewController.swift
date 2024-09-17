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
        addBackButton(selector: #selector(didTapBackButton))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
