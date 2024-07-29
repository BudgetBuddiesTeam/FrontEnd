//
//  MonthPickerViewController.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/29/24.
//

import UIKit
import SnapKit

final class MonthPickerViewController: DimmedViewController {
    // MARK: - Properties
    private let monthPicker = MonthPicker()
    
    // MARK: - init
    override init() {
        super.init()
        
        setupUI()
        setupTapGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.view.addSubview(monthPicker)
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        monthPicker.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(283)
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Set up Tap Gestures
    private func setupTapGestures() {
      self.view.isUserInteractionEnabled = true
      let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
      view.addGestureRecognizer(viewTapGesture)

      // 뒷 배경만을 눌렀을 경우에 dismiss가 되도록
      // bottomSheet에 temp gesture 설정
      // 다른 방법이 있다면 추후에 수정할 예정
      monthPicker.isUserInteractionEnabled = true
      let tempTapGesture = UITapGestureRecognizer(target: self, action: nil)
      monthPicker.addGestureRecognizer(tempTapGesture)
    }
    
    // MARK: - Selectors
    @objc
    private func didTapView() {
        self.dismiss(animated: true, completion: nil)
    }
}
