//
//  RootTabBarController.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/19/24.
//

import UIKit

final class RootTabBarController: CustomTabBarController {

  // MARK: - Properties

  // Model
  internal let mainModel: MainModel

  // Controller
  internal let mainViewController: MainViewController
  internal let consumeViewController: ConsumeViewController
  internal let calendarViewController: CalendarViewController
  internal let allLookingViewController: AllLookingViewController

  // Navigtation Controller
  private let mainViewNavigationController: UINavigationController
  private let consumeViewNavigationController: UINavigationController
  private let calendarViewNavigationController: UINavigationController
  private let allLookingViewNavigationController: UINavigationController

  init(userId: Int) {
    self.mainModel = MainModel(userId: userId)

    self.mainViewController = MainViewController(mainModel: self.mainModel)
    self.consumeViewController = ConsumeViewController()
    self.calendarViewController = CalendarViewController()
    self.allLookingViewController = AllLookingViewController()

    self.mainViewNavigationController = UINavigationController(
      rootViewController: self.mainViewController)
    self.consumeViewNavigationController = UINavigationController(
      rootViewController: self.consumeViewController)
    self.calendarViewNavigationController = UINavigationController(
      rootViewController: self.calendarViewController)
    self.allLookingViewNavigationController = UINavigationController(
      rootViewController: self.allLookingViewController)

    super.init(nibName: nil, bundle: nil)
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
