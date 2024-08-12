//
//  CalendarViewController2.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/12/24.
//

import UIKit

class CalendarViewController2: UIViewController {
    // MARK: - Properties
    
    // MARK: - UI Components

    // MARK: - Life Cycle ⭐️
    override func loadView() {
        self.view = CalendarView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Set up UI
    
    // MARK: - Set up Constraints
}
