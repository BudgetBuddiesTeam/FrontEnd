//
//  StartViewController.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/16/24.
//

import UIKit

final class StartViewController: UIViewController {
    // MARK: - Properties
    let startView = StartView()
    
    
    // MARK: - Life Cycle
    override func loadView() {
        self.view = startView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonAction()
    }
    
    // MARK: - Set Button Action
    private func setButtonAction() {
        startView.tempButton.addTarget(self, action: #selector(didTapTempButton), for: .touchUpInside)
        
        startView.nextButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    @objc
    private func didTapStartButton() {
        // ⭐️ 임시로 다른 뷰컨으로 가도록 함 나중에 꼭 수정
        let numberAuthenticationVC = NumberAuthenticationViewController()
        let basicInformationVC = BasicInformationViewController()
        self.navigationController?.pushViewController(numberAuthenticationVC, animated: true)
//        self.navigationController?.pushViewController(basicInformationVC, animated: true)
        
    }
    
    @objc
    private func didTapTempButton() {
        dismiss(animated: true, completion: nil)
    }
}
