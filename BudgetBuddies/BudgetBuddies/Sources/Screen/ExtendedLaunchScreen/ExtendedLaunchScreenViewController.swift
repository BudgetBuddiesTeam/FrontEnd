//
//  ExtendedLaunchScreenViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/23/24.
//

import UIKit

class ExtendedLaunchScreenViewController: UIViewController {

  // MARK: - Properties

  // View Properties
  private let extendedLaunchScreenView = ExtendedLaunchScreenView()

  // Controller Properties
  private let rootTabBarController = RootTabBarController()

  // Variable Properties
  private let userId = 1

  // MARK: - View Life Cycle

  override func loadView() {
    view = extendedLaunchScreenView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.fetchMainModelData()
    Thread.sleep(forTimeInterval: 3)
    self.connectRootTabBarController()
  }

  // MARK: - Methods

  private func fetchMainModelData() {
    self.rootTabBarController.mainViewController.fetchUserDataFromServer(userId: self.userId)
    self.rootTabBarController.mainViewController.fetchDataFromMainPageAPI(userId: self.userId)
    self.rootTabBarController.calendarViewController.setupData()
    self.rootTabBarController.allLookingViewController.fetchUserData(userId: self.userId)
  }

  private func connectRootTabBarController() {
    if let window = view.window {
      UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
        window.rootViewController = self.rootTabBarController
      }
    }
  }
}
