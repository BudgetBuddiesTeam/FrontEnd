//
//  CustomTabBarController.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/19/24.
//

import UIKit
import SnapKit

class CustomTabBarController: UIViewController {
    // MARK: - Properties
    private lazy var viewControllers: [UIViewController] = []
    private lazy var buttons: [UIButton] = []
    
    var selectedIndex = 0 {
        willSet {
            previewsIndex = selectedIndex
        }
        didSet {
            updateView()
        }
    }
    
    private var previewsIndex = 0
    
    // MARK: - UI Components
    private lazy var tabBarView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10  //반경
        view.layer.shadowOffset = CGSize(width: 0, height: -5)
        view.layer.masksToBounds = false
        
        return view
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // MARK: - Set up View Controllers
    func setupViewControllers(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        setupButtons()
        updateView()
    }
    
    // MARK: - Set up TabBar
    private func setupTabBar() {
        view.addSubview(tabBarView)
        
        tabBarView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-80)
        }
    }
    
    // MARK: - Set up Buttons (탭바 버튼)
    private func setupButtons() {
        // 버튼의 넓이는 tab 개수에 맞춰서 유동적으로 변함
        let buttonWidth = view.bounds.width / CGFloat(viewControllers.count)
        
        // 터치 되는 범위(버튼) 설정
        for (index, _) in viewControllers.enumerated() {
            let button = UIButton()
            button.tag = index
//            button.layer.borderWidth = 1
            button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
            tabBarView.addSubview(button)
            
            button.snp.makeConstraints { make in
                make.top.equalTo(tabBarView.snp.top)
                make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
                make.leading.equalTo(tabBarView.snp.leading).offset(CGFloat(index) * buttonWidth)
                make.width.equalTo(buttonWidth)
                
            }
            
            buttons.append(button)
        }
    }
    
    // MARK: - Update View
    private func updateView() {
        print("\(selectedIndex)번호 뷰로 바꿈")
        deleteView()
        setupView()
        
        buttons.forEach { $0.isSelected = ($0.tag == selectedIndex) }
    }
        
    // MARK: - Delete View
    private func deleteView() {
        let previousVC = viewControllers[previewsIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
    }
        
    // MARK: - Set up View
    private func setupView() {
        let selectedVC = viewControllers[selectedIndex]
        
        self.addChild(selectedVC)
        view.insertSubview(selectedVC.view, belowSubview: tabBarView)
        
        selectedVC.view.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(self.tabBarView.snp.top).inset(10)
        }
        
        selectedVC.didMove(toParent: self)
    }
    
    // MARK: - Selectors
    // 탭바 버튼 누르면 tag바꾸기
    @objc private func tabButtonTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
        print("CustomTabBarController: \(selectedIndex) 눌림")
    }
}
