//
//  UIViewController+.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/22/24.
//

import UIKit

extension UIViewController {
    func setupDefaultNavigationBar(backgroundColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        // 색상
        appearance.backgroundColor = backgroundColor
        appearance.shadowColor = nil
        
        // 네비게이션 바 타이틀 폰트, 자간 설정
        let titleFont = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 18)
        let titleAttributes: [NSAttributedString.Key: Any] = [
          .font: titleFont,
          .foregroundColor: BudgetBuddiesAsset.AppColor.textBlack.color,
          .kern: -0.45,
        ]

        appearance.titleTextAttributes = titleAttributes

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.isHidden = false
    }
}
