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
    
    var regionArray: [String] = [
        "서울특별시",
        "인천광역시",
        "경기도",
        "강원도",
        "대전광역시",
        "충청북도",
        "충청남도",
        "부산광역시",
        "대구광역시",
        "경상북도",
        "경상남도",
        "광주광역시",
        "전라북도",
        "제주특별자치도"
    ]
    
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
        
        regionPicker.regionTableView.separatorStyle = .none
        
        regionPicker.regionTableView.dataSource = self
        regionPicker.regionTableView.delegate = self
        
    }
    
    // 셀 등록
    private func registerCells() {
        regionPicker.regionTableView.register(RegionCell.self, forCellReuseIdentifier: RegionCell.identifier)
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

// MARK: - UITableView DataSource
extension RegionPickerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let regionCount = self.regionArray.count
        return regionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let regionCell = regionPicker.regionTableView.dequeueReusableCell(withIdentifier: RegionCell.identifier, for: indexPath) as! RegionCell
        
        regionCell.region = self.regionArray[indexPath.row]
        
        return regionCell
    }
}

// MARK: - UITableView Delegate
extension RegionPickerViewController: UITableViewDelegate {
    
}
