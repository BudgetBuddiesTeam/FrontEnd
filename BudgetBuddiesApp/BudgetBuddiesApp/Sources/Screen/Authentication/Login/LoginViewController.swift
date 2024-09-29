//
//  LoginViewController.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/29/24.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - Properties
    let loginView = LoginView()

    // MARK: - Life Cycle
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
