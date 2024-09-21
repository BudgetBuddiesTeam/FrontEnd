//
//  BaseViewController.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 9/17/24.
//

import UIKit

public protocol BaseViewProtocol {
    /// View property 설정 - ex) view.backgroundColor = .black
    func setUpViewProperty()
    /// view 계층 설정 - ex) view.addSubview()
    func setUp()
    /// Layout 설정 - ex) snapkit
    func setLayout()
    /// Delegate 설정 - ex) collectionview.delegate = self
    func setDelegate()
    /// 기능 설정
    func setFunc()
}

open class BaseViewController: UIViewController, BaseViewProtocol {
    
    public init() {
           super.init(nibName: nil, bundle: nil)
       }

    @available(*, unavailable, message: "remove required init")
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewProperty()
        setUp()
        setLayout()
        setDelegate()
        setFunc()
    }
    
    open func setUpViewProperty(){}
    
    open func setUp() {}
    
    open func setLayout(){}
    
    open func setDelegate(){}
    
    open func setFunc(){}
    
}

//extension BaseViewController {
//  /// 기본 네비게이션바 세팅하는 함수입니다.
//  ///
//  /// - Parameter backgroundColor: 배경 색입니다.
//  func setupDefaultNavigationBar(backgroundColor: UIColor) {
//    let appearance = UINavigationBarAppearance()
//    appearance.configureWithDefaultBackground()
//    // 색상
//    appearance.backgroundColor = backgroundColor
//    appearance.shadowColor = nil
//
//    // 네비게이션 바 타이틀 폰트, 자간 설정
//    let titleFont = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 18)
//    let titleAttributes: [NSAttributedString.Key: Any] = [
//      .font: titleFont,
//      .foregroundColor: BudgetBuddiesAppAsset.AppColor.textBlack.color,
//      .kern: -0.45,
//    ]
//
//    appearance.titleTextAttributes = titleAttributes
//
//    navigationController?.navigationBar.standardAppearance = appearance
//    navigationController?.navigationBar.compactAppearance = appearance
//    navigationController?.navigationBar.scrollEdgeAppearance = appearance
//    navigationController?.navigationBar.isHidden = false
//  }
//
//  /// 네비게이션바 회색 백 버튼을 설정하는 함수입니다.
//  ///
//  /// - Parameter selector: selector함수입니다. #selector(<함수이름>)형식입니다.
//  func addBackButton(selector: Selector) {
//    lazy var backButton: UIBarButtonItem = {
//      let btn = UIBarButtonItem(
//        image: UIImage(systemName: "chevron.left"),
//        style: .done,
//        target: self,
//        action: selector)
//      btn.tintColor = BudgetBuddiesAppAsset.AppColor.subGray.color
//      return btn
//    }()
//
//    navigationItem.leftBarButtonItem = backButton
//  }
//}
//
//extension BaseViewController {
//  func hasPreviousViewController() -> Bool {
//    return self.navigationController?.viewControllers.count ?? 0 > 1
//  }
//}
