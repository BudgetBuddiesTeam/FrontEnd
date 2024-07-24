//
//  DimmedViewController.swift
//  BudgetBuddiesLocal
//
//  Created by 김승원 on 7/21/24.
//

import UIKit

class DimmedViewController: UIViewController {
    private let dimmedView = UIView()

    // MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .coverVertical
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let presentingViewController else { return }
        dimmedView.backgroundColor = .black
        dimmedView.alpha = 0
        presentingViewController.view.addSubview(dimmedView)
        
        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.dimmedView.alpha = 0.25
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dimmedView.removeFromSuperview()
        }
    }
}
