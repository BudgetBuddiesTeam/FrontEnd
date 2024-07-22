//
//  RootTabBarViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/22/24.
//

import UIKit

class RootTabBarViewController: UITabBarController {
  // MARK: - Properties

  private let consumeViewController = ConsumeViewController()
  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    setTabBar()
  }
  // MARK: - Methods

  private func setTabBar() {
    consumeViewController.tabBarItem = UITabBarItem(
      title: "가계부", image: UIImage(systemName: "book.closed.fill"), tag: 1)

    setViewControllers([consumeViewController], animated: true)
  }

}
