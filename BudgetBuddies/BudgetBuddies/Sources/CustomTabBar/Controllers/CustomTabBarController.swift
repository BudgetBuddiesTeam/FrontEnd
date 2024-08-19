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
    private var tabBarIcons: [UIImage] = [
        UIImage(systemName: "house.fill")!,
        UIImage(systemName: "book.closed.fill")!,
        UIImage(systemName: "calendar")!,
        UIImage(systemName: "ellipsis")!
    ]
    private var tabBarLabels: [String] = ["홈", "가계부", "정보", "전체"]
    private var tabBarIconSizes: [Int] = [29, 24, 25, 24]
    
    private let marginInset = 20
    
    var selectedIndex = 0 {
        willSet {
            previewsIndex = selectedIndex
        }
        didSet {
            updateView()
            updateButtons()
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
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: -5)
        return view
    }()
    
    private lazy var tabBarMargin: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
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
        
        tabBarView.addSubview(tabBarMargin)
        tabBarMargin.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(marginInset)
        }
    }
    
    // MARK: - Set up Buttons (탭바 버튼)
    private func setupButtons() {
        buttons.forEach { $0.removeFromSuperview() } // Remove old buttons
        buttons.removeAll()
            
        let buttonWidth = (view.bounds.width - CGFloat(marginInset * 2)) / CGFloat(viewControllers.count)
        
        for (index, _) in viewControllers.enumerated() {
            let tabBarButton = UIButton()
            tabBarButton.tag = index
            tabBarButton.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
            tabBarMargin.addSubview(tabBarButton)
            
            tabBarButton.snp.makeConstraints { make in
                make.top.equalTo(tabBarMargin.snp.top)
                make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
                make.leading.equalTo(tabBarMargin.snp.leading).offset(CGFloat(index) * buttonWidth)
                make.width.equalTo(buttonWidth)
            }
            
            let tabBarIcon = CustomTabBarIcon(tabBarIcon: tabBarIcons[index],
                                        tabBarLabel: tabBarLabels[index],
                                        size: tabBarIconSizes[index])
            
            tabBarButton.addSubview(tabBarIcon)
            tabBarIcon.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview().inset(8)
            }
            
            buttons.append(tabBarButton)
        }
        
        updateButtons() // Initial update of buttons
    }
    
    // MARK: - Update Buttons
    private func updateButtons() {
        for (index, button) in buttons.enumerated() {
            let isSelected = selectedIndex == index
            button.isSelected = isSelected
            if let tabBarIcon = button.subviews.compactMap({ $0 as? CustomTabBarIcon }).first {
                tabBarIcon.updateAppearance(isSelected: isSelected)
            }
        }
    }
    
    // MARK: - Update View
    private func updateView() {
        deleteView()
        setupView()
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
    @objc private func tabButtonTapped(_ sender: UIButton) {
        if selectedIndex != sender.tag {
            selectedIndex = sender.tag
        } else {
            
            // 선택된 NavController가져오기
            if let navController = viewControllers[selectedIndex] as? UINavigationController {
                
                if navController.viewControllers.count > 1 {
                    navController.popToRootViewController(animated: true)
                    
                    print("CustomTabBarController: To RootViewController")
                } else {
                    // 현재 뷰가 root뷰컨(젤 처음)이라면 리프레시
                    if let rootViewController = navController.viewControllers.first {
                        // 루트 뷰 컨트롤러의 view에서 UIScrollView를 찾습니다.
                        if let scrollView = findScrollView(in: rootViewController.view) {
                            scrollView.layoutIfNeeded()
                                                    
                            // Safe Area까지 정확히 스크롤되도록 설정
                            let topInset = scrollView.adjustedContentInset.top
                            scrollView.setContentOffset(CGPoint(x: 0, y: -topInset), animated: true)
                            
                            print("CustomTabBarController: ScrollView REFRESH")
                        }
                    }
                    
                    print("CustomTabBarController: RootViewController REFRESH")
                }
            }
        }
    }
    
    // MARK: - Function
    // 서브뷰에서 UIScrollView를 찾는 함수
    private func findScrollView(in view: UIView) -> UIScrollView? {
        for subview in view.subviews {
            if let scrollView = subview as? UIScrollView {
                return scrollView
            } else if let found = findScrollView(in: subview) {
                return found
            }
        }
        return nil
    }
}
