//
//  CalendarViewController2.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/12/24.
//

import UIKit

class CalendarViewController2: UIViewController {
    // MARK: - Properties
    var yearMonth: YearMonth? {
        didSet {
            setupData()
            calendarView.mainCalendarView.yearMonth = self.yearMonth
        }
    }
    
    // MARK: - UI Components
    var calendarView = CalendarView()
    

    // MARK: - Life Cycle ⭐️
    override func loadView() {
        self.view = calendarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupTableViews()
        setupButtonActions()
    }
    // MARK: - Set up Data
    private func setupData() {
        print(#function)
    }
    
    // MARK: - Set up TableViews
    private func setupTableViews() {
        // 할인정보 테이블 뷰
        let discountTV = calendarView.discountInfoTableView
        discountTV.delegate = self
        discountTV.dataSource = self
        
        discountTV.register(InformationCell.self, forCellReuseIdentifier: InformationCell.identifier)
        
        // 지원정보 테이블 뷰
        let supportTV = calendarView.supportInfoTableView
        supportTV.delegate = self
        supportTV.dataSource = self
        
        supportTV.register(InformationCell.self, forCellReuseIdentifier: InformationCell.identifier)
    }
    
    // MARK: - Set up Button Actions
    // 뷰컨에서 버튼 액션 관리
    private func setupButtonActions() {
        // 할인정보 전체보기 제스처
        let discountDetailTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapShowDetail))
        calendarView.discountInfoTitleWithButtonView.showDetailStackView.addGestureRecognizer(discountDetailTapGesture)
    
        // 지원정보 전체보기 제스처
        let supportDetailTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapShowDetail))
        calendarView.supportInfoTitleWithButtonView.showDetailStackView.addGestureRecognizer(supportDetailTapGesture)
        
        // 캘린더 선택 제스처
        let selectCalendarTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSelectCalendar))
        calendarView.mainCalendarView.yearMonthStackView.addGestureRecognizer(selectCalendarTapGesture)
        
        // 버튼 액션
    }
    
    // MARK: - Selectors
    @objc
    private func didTapShowDetail() {
        print(#function)
    }
    
    @objc
    private func didTapSelectCalendar() {
        print(#function)
        let vc = MonthPickerViewController()
        vc.yearMonth = yearMonth
        
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - UITableView DataSource
extension CalendarViewController2: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == calendarView.discountInfoTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: InformationCell.identifier, for: indexPath) as! InformationCell
            cell.configure(infoType: .discount)
            
            cell.selectionStyle = .none
            return cell
        }
        
        if tableView == calendarView.supportInfoTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: InformationCell.identifier, for: indexPath) as! InformationCell
            cell.configure(infoType: .support)
            
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITableView Delegate
extension CalendarViewController2: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
}

extension CalendarViewController2: MonthPickerViewControllerDelegate {
    // MonthPickerViewController에서 년월 선택버튼 누르는 시점
    func didTapSelectButton(year: Int, month: Int) {
        self.yearMonth = YearMonth(year: year, month: month)
    }
}
