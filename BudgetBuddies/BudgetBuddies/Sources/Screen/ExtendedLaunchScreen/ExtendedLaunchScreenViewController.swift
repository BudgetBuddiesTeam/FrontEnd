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
  private let extendedLaunchScreenView: ExtendedLaunchScreenView!

  // Controller Properties
  private let rootTabBarController: RootTabBarController!

  // Variable Properties
  private static let userId = 1

  // MARK: - Intializer

  init() {
    self.extendedLaunchScreenView = ExtendedLaunchScreenView()
    self.rootTabBarController = RootTabBarController(
      userId: ExtendedLaunchScreenViewController.userId)

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Life Cycle

  override func loadView() {
    view = extendedLaunchScreenView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.fetchModelDataFromServer()
    Thread.sleep(forTimeInterval: 3)
    self.connectRootTabBarController()
  }

  // MARK: - Methods

  private func fetchModelDataFromServer() {
    self.rootTabBarController.mainModel.reloadDataFromServer()
    self.rootTabBarController.calendarViewController.setupData()
    self.rootTabBarController.allLookingViewController.fetchUserData(
      userId: ExtendedLaunchScreenViewController.userId)
  }

  private func connectRootTabBarController() {
    if let window = view.window {
      UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
        window.rootViewController = self.rootTabBarController
      }
    }
  }
}
