//
//  ConsumedHistoryTableViewController.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 7/25/24.
//

import UIKit
import SnapKit

class ConsumedHistoryTableViewController: UITableViewController {
  // MARK: - Properties
  
  private let consumedHistoryView = ConsumedHistoryView()

  // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
      
      tableView.register(ConsumedHistoryTableViewCell.self, forCellReuseIdentifier: ConsumedHistoryTableViewCell.identifier)
      tableView.separatorStyle = .none
      view.backgroundColor = BudgetBuddiesAsset.AppColor.white.color
      setNavigation()
    }
  
  // MARK: - Methods
  
  private func setNavigation() {
    navigationController?.navigationBar.tintColor = BudgetBuddiesAsset.AppColor.barGray.color
    navigationItem.backBarButtonItem = UIBarButtonItem()
  }
  
  private func addAccountBookView() {
    view.addSubview(consumedHistoryView)
    
    consumedHistoryView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  // MARK: - UITableView Delegate & DataSource
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 10
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ConsumedHistoryTableViewCell.identifier, for: indexPath) as! ConsumedHistoryTableViewCell
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 64
  }
}
