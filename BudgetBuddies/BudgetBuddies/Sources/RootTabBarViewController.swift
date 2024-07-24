//
//  RootTabBarViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/22/24.
//

import UIKit

class RootTabBarViewController: UITabBarController {
  // MARK: - Properties

  private let mainViewController = UINavigationController(rootViewController: MainViewController())
  private let consumeViewController = UINavigationController(
    rootViewController: ConsumeViewController())
  private let calendarViewController = UINavigationController(
    rootViewController: CalendarViewController())

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    setTabBar()
  }

  // MARK: - Methods

  private func setTabBar() {
    mainViewController.tabBarItem = UITabBarItem(
      title: "홈", image: UIImage(systemName: "house"), tag: 0)
    consumeViewController.tabBarItem = UITabBarItem(
      title: "가계부", image: UIImage(systemName: "book.closed.fill"), tag: 1)
    calendarViewController.tabBarItem = UITabBarItem(
      title: "정보", image: UIImage(systemName: "calendar"), tag: 2)

    setViewControllers(
      [mainViewController, consumeViewController, calendarViewController], animated: true)
  }

}
