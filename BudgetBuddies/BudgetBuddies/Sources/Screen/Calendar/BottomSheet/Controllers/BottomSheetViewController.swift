//
//  BottomSheetViewController.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/27/24.
//

import UIKit
import SnapKit

final class BottomSheetViewController: DimmedViewController {
    // MARK: - Properties
    private let bottomSheet = BottomSheet()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTapGesture()
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.view.addSubview(bottomSheet)
        
        setupConstraint()
    }
    
    // MARK: - Set up Constraints {
    private func setupConstraint() {
        bottomSheet.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(460)
        }
    }
    
    // MARK: - Set up View TapGesture
    private func setupTapGesture() {
        self.view.isUserInteractionEnabled = true
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(viewTapGesture)
        
        // 뒷 배경만을 눌렀을 경우에 dismiss가 되도록
        // bottomSheet에 temp gesture 설정
        // 다른 방법이 있다면 추후에 수정할 예정
        bottomSheet.isUserInteractionEnabled = true
        let tempTapGesture = UITapGestureRecognizer(target: self, action: nil)
        bottomSheet.addGestureRecognizer(tempTapGesture)
    }
    
    // MARK: - Selectors
    @objc
    private func didTapView() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }
}
