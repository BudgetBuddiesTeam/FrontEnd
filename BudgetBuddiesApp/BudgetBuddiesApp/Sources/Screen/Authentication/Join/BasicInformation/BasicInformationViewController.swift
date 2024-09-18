//
//  BasicInformationViewController.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/18/24.
//

import UIKit

class BasicInformationViewController: UIViewController {
    // MARK: - Properties
    let basicInformationView = BasicInformationView()

    // MARK: - Life Cycle
    override func loadView() {
        self.view = basicInformationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
    
    // MARK: - Set up NavigationBar
    private func setupNavigationBar() {
        setupDefaultNavigationBar(backgroundColor: BudgetBuddiesAppAsset.AppColor.white.color)
        addBackButton(selector: #selector (didTapBackButton))
    }
    
    // MARK: - Selectors
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
