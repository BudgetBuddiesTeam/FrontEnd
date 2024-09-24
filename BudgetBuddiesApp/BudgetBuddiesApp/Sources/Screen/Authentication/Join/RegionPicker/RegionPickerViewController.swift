//
//  RegionPickerViewController.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/24/24.
//

import UIKit
import SnapKit

class RegionPickerViewController: DimmedViewController {
    // MARK: - Properties
    private let regionPicker = RegionPicker()
    
    private var regionPickerValue: CGFloat {
        return self.view.bounds.height * 0.4
    }
    
    private var regionPickerTopConstraint: Constraint?
    private var regionPickerBottomConstraint: Constraint?
    
    // MARK: - Lice Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRegionPicker()
        setupTapGestures()
        setupTableView()
    }
    
    // MARK: - Set up TableView
    private func setupTableView() {
        registerCells()
        
    }
    
    // 셀 등록
    private func registerCells() {
        
    }
    
    // MARK: - Set up TapGestures
    private func setupTapGestures() {
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
        
        // regionPicker 터치 겹치지 않게
        let tempGesture = UITapGestureRecognizer(target: self, action: nil)
        tempGesture.cancelsTouchesInView = false
        regionPicker.addGestureRecognizer(tempGesture)
        
    }
    
    // MARK: - Set up Region Picker
    private func setupRegionPicker() {
        self.view.addSubviews(regionPicker)
        
        regionPicker.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            regionPickerTopConstraint =  make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(regionPickerValue).constraint
            regionPickerBottomConstraint = make.bottom.equalTo(self.view.snp.bottom).inset(0).constraint
            
        }
    }
    
    // MARK: - Selectors
    @objc
    private func didTapView() {
        self.dismiss(animated: true, completion: nil)
    }
}
