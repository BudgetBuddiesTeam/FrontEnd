//
//  InfoListViewController.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/26/24.
//

import UIKit

class InfoListViewController: UIViewController {
    // MARK: - Properties
    enum InfoType {
        case discount
        case support
    }
    
    var infoType: InfoType
    
    // MARK: - UI Components
    lazy var tableView = UITableView()

    // MARK: - Life Cycle
    init(infoType: InfoType) {
        self.infoType = infoType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    // MARK: - Set up TableView
    private func setupTableView() {
        self.view.backgroundColor = BudgetBuddiesAsset.AppColor.background.color
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.scrollsToTop = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // 셀 등록
        tableView.register(InformationCell.self, forCellReuseIdentifier: "InfomationCell")
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableView DataSource
extension InfoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = UITableViewCell()
            cell.backgroundColor = .clear
            return cell
            
        } else {
            switch infoType {
            case .discount:
                let informationCell = tableView.dequeueReusableCell(withIdentifier: InformationCell.identifier, for: indexPath) as! InformationCell
                informationCell.configure(infoType: .discount)
                
                informationCell.infoTitleLabel.text = "지그재그 썸머세일"
                informationCell.dateLabel.text = "08.17 ~ 08.20"
                informationCell.percentLabel.text = "~80%"
                informationCell.urlString = "https://www.naver.com"
                
                return informationCell
            case.support:
                let informationCell = tableView.dequeueReusableCell(withIdentifier: InformationCell.identifier, for: indexPath) as! InformationCell
                informationCell.configure(infoType: .support)
                
                informationCell.infoTitleLabel.text = "국가장학금 1차 신청"
                informationCell.dateLabel.text = "08.17 ~ 08.20"
                informationCell.urlString = "https://www.google.com"
                
                return informationCell
            }
        }
    }
}

// MARK: - UITableView Delegate
extension InfoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 30
            
        } else {
            return 168
            
        }
    }
}
