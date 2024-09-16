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
        
    }
}
