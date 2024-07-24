//
//  UIView+.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/22/24.
//

import Foundation
import UIKit

extension UIView {
  func addSubviews(_ views: UIView...) {
    views.forEach { addSubview($0) }
  }
}
