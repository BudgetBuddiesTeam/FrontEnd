//
//  RootTabBarController.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/19/24.
//

import UIKit

class RootTabBarController: CustomTabBarController {
  // MARK: - Properties

  // Controller

  public let mainViewController: MainViewController!
  public let consumeViewController: ConsumeViewController!
  public let calendarViewController: CalendarViewController!
  public let allLookingViewController: AllLookingViewController!

  private let mainViewNavigationController: UINavigationController!
  private let consumeViewNavigationController: UINavigationController!
  private let calendarViewNavigationController: UINavigationController!
  private let allLookingViewNavigationController: UINavigationController!

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {

    mainViewController = MainViewController()
    consumeViewController = ConsumeViewController()
    calendarViewController = CalendarViewController()
    allLookingViewController = AllLookingViewController()

    mainViewNavigationController = UINavigationController(rootViewController: mainViewController)
    consumeViewNavigationController = UINavigationController(
      rootViewController: consumeViewController)
    calendarViewNavigationController = UINavigationController(
      rootViewController: calendarViewController)
    allLookingViewNavigationController = UINavigationController(
      rootViewController: allLookingViewController)

    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    setupTabBar()
  }

  // MARK: - Set up TabBar
  private func setupTabBar() {
    self.view.backgroundColor = BudgetBuddiesAsset.AppColor.background.color

    self.setupViewControllers([
      mainViewNavigationController,
      consumeViewNavigationController,
      calendarViewNavigationController,
      allLookingViewNavigationController,
    ])
  }
}
