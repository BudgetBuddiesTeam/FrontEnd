//
//  NoticeView.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 11/25/24.
//

import UIKit
import SnapKit

class NoticeView: BaseView {
    
    // MARK: - Properties

    // MARK: - UI Components
    public lazy var tableView = {
        let tableView = UITableView()
        tableView.register(NoticeTableViewCell.self, forCellReuseIdentifier: NoticeTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    // MARK: - Function
    override func initUI() {
        self.addSubview(tableView)
    }
    
    override func initLayout() {
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
