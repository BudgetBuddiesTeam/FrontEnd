//
//  RootTabBarController.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/19/24.
//

import UIKit

class RootTabBarController: CustomTabBarController {
    // MARK: - Properties
    private let mainViewController = UINavigationController(rootViewController: MainViewController())
    private let consumeViewController = UINavigationController(rootViewController: ConsumeViewController())
    private let calendarViewController = UINavigationController(rootViewController: CalendarViewController())
    private let allLookingViewController = UINavigationController(rootViewController: AllLookingViewController())
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    // MARK: - Set up TabBar
    private func setupTabBar() {
        self.view.backgroundColor = BudgetBuddiesAsset.AppColor.background.color
        
        self.setupViewControllers([mainViewController,
                                   consumeViewController,
                                   calendarViewController,
                                   allLookingViewController])
    }
}
