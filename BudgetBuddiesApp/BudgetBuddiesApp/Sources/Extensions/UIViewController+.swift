//
//  UIViewController+.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/22/24.
//

import UIKit

extension UIViewController {

  /// 기본 네비게이션바 세팅하는 함수입니다.
  ///
  /// - Parameter backgroundColor: 배경 색입니다.
  func setupDefaultNavigationBar(backgroundColor: UIColor) {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithDefaultBackground()
    // 색상
    appearance.backgroundColor = backgroundColor
    appearance.shadowColor = nil

    // 네비게이션 바 타이틀 폰트, 자간 설정
    let titleFont = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 18)
    let titleAttributes: [NSAttributedString.Key: Any] = [
      .font: titleFont,
      .foregroundColor: BudgetBuddiesAppAsset.AppColor.textBlack.color,
      .kern: -0.45,
    ]

    appearance.titleTextAttributes = titleAttributes

    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    navigationController?.navigationBar.isHidden = false
  }

  /// 네비게이션바 회색 백 버튼을 설정하는 함수입니다.
  ///
  /// - Parameter selector: selector함수입니다. #selector(<함수이름>)형식입니다.
  func addBackButton(selector: Selector) {
    lazy var backButton: UIBarButtonItem = {
      let btn = UIBarButtonItem(
        image: UIImage(systemName: "chevron.left"),
        style: .done,
        target: self,
        action: selector)
      btn.tintColor = BudgetBuddiesAppAsset.AppColor.subGray.color
      return btn
    }()

    navigationItem.leftBarButtonItem = backButton
  }
}

extension UIViewController {
  func hasPreviousViewController() -> Bool {
    return self.navigationController?.viewControllers.count ?? 0 > 1
  }
}
