//
//  CalendarViewController2.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/12/24.
//

import UIKit

class CalendarViewController2: UIViewController {
    // MARK: - Properties
    
    // MARK: - UI Components
    var calendarView = CalendarView()
    

    // MARK: - Life Cycle ⭐️
    override func loadView() {
        self.view = calendarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViews()
        setupButtonActions()
    }
    
    // MARK: - Set up TableViews
    private func setupTableViews() {
        // 할인정보 테이블 뷰
        let discountTV = calendarView.discountInfoTableView
        discountTV.delegate = self
        discountTV.dataSource = self
        
        discountTV.register(InformationCell.self, forCellReuseIdentifier: InformationCell.identifier)
    }
    
    // MARK: - Set up Button Actions
    // 뷰컨에서 버튼 액션 관리
    private func setupButtonActions() {
        // 할인정보, 지원정보 전체보기 제스처
        let DTtapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapShowDetail))
        calendarView.discountInfoTitleWithButtonView.showDetailStackView.addGestureRecognizer(DTtapGesture)
        // 버튼 액션
        
    }
    
    // MARK: - Set up UI
    
    // MARK: - Set up Constraints
    
    // MARK: - Selectors
    @objc
    private func didTapShowDetail() {
        print(#function)
    }
}

// MARK: - UITableView DataSource
extension CalendarViewController2: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InformationCell.identifier, for: indexPath) as! InformationCell
        cell.configure(infoType: .discount)
        
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableView Delegate
extension CalendarViewController2: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
}
