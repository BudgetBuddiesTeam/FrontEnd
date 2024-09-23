//
//  AdditionalInformationViewController.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/18/24.
//

import UIKit

class AdditionalInformationViewController: UIViewController {
    // MARK: - Properties
    let additionalInformationView = AdditionalInformationView()

    // MARK: - Life Cycle
    override func loadView() {
        self.view = additionalInformationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupButtonActions()
    }
    
    // MARK: - Set up Navigation Bar
    private func setupNavigationBar() {
        setupDefaultNavigationBar(backgroundColor: BudgetBuddiesAppAsset.AppColor.white.color)
        addBackButton(selector: #selector(didTapBackButton))
    }
    
    // MARK: - Set up Button Actions
    private func setupButtonActions() {
        // 통신사 버튼 actions
        additionalInformationView.mobileCarrierButtonArray.forEach {
            $0.addTarget(self, action: #selector(didTapMobileCarrierButton), for: .touchUpInside)
        }
        
        // 관심 카테고리 actions
        additionalInformationView.interestedCategoryButtonArray.forEach {
            $0.addTarget(self, action: #selector(didTapInterestedCategoryButton), for: .touchUpInside)
        }
    }
    
    // MARK: - Selectors
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapMobileCarrierButton(sender: ClearBackgroundRadioButton) {
        additionalInformationView.moblieCarrierRadioButtonToggle(sender)
        
        
    }
    
    @objc
    private func didTapInterestedCategoryButton(sender: ClearBackgroundCheckBoxButton) {
        sender.toggleButton()
        print("\(sender.interestedCategory) \(sender.isButtonTapped)")
    }
}
