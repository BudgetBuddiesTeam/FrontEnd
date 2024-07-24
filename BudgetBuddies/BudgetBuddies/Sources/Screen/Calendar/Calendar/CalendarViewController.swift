//
//  CalendarViewController.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/24/24.
//

import UIKit
import SnapKit

final class CalendarViewController: UIViewController {
    // MARK: - Properties
//    private let heightBetweenCells: CGFloat = 12
//    private let heightOfCell: CGFloat = 72
    
    // MARK: - UI Components
    lazy var tableView = UITableView()

    // MARK: - Life Cycle ⭐️
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BudgetBuddiesAsset.AppColor.background.color
        
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    // MARK: - Set up NavigationBar
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Set up TableView
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // 셀 등록
        tableView.register(BannerCell.self, forCellReuseIdentifier: BannerCell.identifier)
        
        self.view.addSubview(tableView)
        
        // 제약조건
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - UITableView DataSource
extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell = UITableViewCell()
        tempCell.backgroundColor = .gray
        
        if indexPath.row == 0 {
            let bannerCell = tableView.dequeueReusableCell(withIdentifier: BannerCell.identifier, for: indexPath) as! BannerCell
            return bannerCell
        }
        
        return tempCell
        
    }
}

// MARK: - UITableView Delegate
extension CalendarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 127
        }
        
        return 100
    }
}
