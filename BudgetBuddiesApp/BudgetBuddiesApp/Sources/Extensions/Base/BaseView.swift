//
//  BaseView.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 9/17/24.
//

import SnapKit
import UIKit

public protocol BaseProtocol {
  /// view 계층 설정 - ex) view.addSubview()
  func initUI()
  /// Layout 설정 - ex) snapkit
  func initLayout()
}

open class BaseView: UIView, BaseProtocol {

  public override init(frame: CGRect) {
    super.init(frame: frame)
    initUI()
    initLayout()
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open func initUI() {}

  open func initLayout() {}
}
