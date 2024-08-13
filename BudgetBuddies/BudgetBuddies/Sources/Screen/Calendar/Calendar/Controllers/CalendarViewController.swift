//
//  CalendarViewController.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/12/24.
//

import UIKit

class CalendarViewController: UIViewController {
    // MARK: - Properties
    var yearMonth: YearMonth? {
        didSet {
            setupData()
            calendarView.yearMonth = self.yearMonth
        }
    }
    
    // MARK: - UI Components
    // 뷰
    var calendarView = CalendarView()

    // MARK: - Life Cycle ⭐️
    override func loadView() {
        self.view = calendarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNowYearMonth()
        setupData()
        setupTableViews()
        setupButtonActions()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    // MARK: - Set up Now YearMonth
    private func setupNowYearMonth() {
        let currentDate = Date()
        let calendar = Calendar.current
        
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        
        // 현재 시간
        self.yearMonth = YearMonth(year: currentYear, month: currentMonth)
        
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
    // 뷰컨에서 버튼 액션 관리 (MVC 패턴)
    private func setupButtonActions() {
        // 할인정보 전체보기 제스처
        let discountDetailTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapShowDiscountDetail))
        calendarView.discountInfoTitleWithButtonView.showDetailStackView.addGestureRecognizer(discountDetailTapGesture)
    
        // 지원정보 전체보기 제스처
        let supportDetailTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapShowSupportDetail))
        calendarView.supportInfoTitleWithButtonView.showDetailStackView.addGestureRecognizer(supportDetailTapGesture)
        
        // 캘린더 선택 제스처
        let selectCalendarTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSelectCalendar))
        calendarView.mainCalendarView.yearMonthStackView.addGestureRecognizer(selectCalendarTapGesture)
        
        // 버튼 액션
    }
    
    // MARK: - Set up Navigation Bar
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Selectors
    @objc
    private func didTapShowDiscountDetail() {
        guard let yearMonth = self.yearMonth else { return }
        guard let month = yearMonth.month else { return }
        
        let vc = InfoListViewController(infoType: .discount)
        vc.title = "\(month)월 할인정보"
        vc.yearMonth = self.yearMonth
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func didTapShowSupportDetail() {
        guard let yearMonth = self.yearMonth else { return }
        guard let month = yearMonth.month else { return }
        
        let vc = InfoListViewController(infoType: .support)
        vc.title = "\(month)월 지원정보"
        vc.yearMonth = self.yearMonth
        self.navigationController?.pushViewController(vc, animated: true)
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
extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 지원정보 테이블 뷰
        if tableView == calendarView.discountInfoTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: InformationCell.identifier, for: indexPath) as! InformationCell
            cell.configure(infoType: .discount)
            
            // 대리자
            cell.delegate = self
            
            cell.selectionStyle = .none
            return cell
        }
        
        // 할인정보 테이블 뷰
        if tableView == calendarView.supportInfoTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: InformationCell.identifier, for: indexPath) as! InformationCell
            cell.configure(infoType: .support)
            
            // 대리자
            cell.delegate = self
            
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITableView Delegate
extension CalendarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BottomSheetViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

extension CalendarViewController: MonthPickerViewControllerDelegate {
    // MonthPickerViewController에서 년월 선택버튼 누르는 시점
    func didTapSelectButton(year: Int, month: Int) {
        self.yearMonth = YearMonth(year: year, month: month)
    }
}

extension CalendarViewController: InformationCellDelegate {
    func didTapWebButton(in cell: InformationCell, urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Error: 유효하지 않은 url \(urlString)")
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
}
