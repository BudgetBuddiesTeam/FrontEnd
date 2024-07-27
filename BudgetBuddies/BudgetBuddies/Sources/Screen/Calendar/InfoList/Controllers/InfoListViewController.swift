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
    
    var previousScrollOffset: CGFloat = 0.0
    var scrollThreshold: CGFloat = 10.0 // 네비게이션 바가 나타나거나 사라질 스크롤 오프셋 차이
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
    }
    
    // MARK: - Set up NavigationBar
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.shadowColor = nil
        
        // 네비게이션 바 타이틀 폰트, 자간 설정
        let titleFont = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 18)
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont,
            .foregroundColor: BudgetBuddiesAsset.AppColor.textBlack.color, // UIColor.red로 변경하려면 이 부분을 수정하세요.
            .kern: -0.45
        ]
        
        appearance.titleTextAttributes = titleAttributes

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.isHidden = false
        
        // 백 버튼
        lazy var backButton: UIBarButtonItem = {
            let btn = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                      style: .done,
                                      target: self,
                                      action: #selector(didTapBarButtonItem))
            btn.tintColor = BudgetBuddiesAsset.AppColor.subGray.color
            return btn
        }()
        
        navigationItem.leftBarButtonItem = backButton
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
        tableView.register(InformationCell.self, forCellReuseIdentifier: InformationCell.identifier)
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Selectors
    @objc
    private func didTapBarButtonItem() {
        self.navigationController?.popViewController(animated: true)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let offsetDifference = currentOffset - previousScrollOffset
        
        if currentOffset <= 0 {
            // 스크롤을 완전히 위로 올렸을 때 네비게이션 바 나타냄
            navigationController?.setNavigationBarHidden(false, animated: true)
        } else if offsetDifference > scrollThreshold {
            // 스크롤이 아래로 일정 이상 이동한 경우 네비게이션 바 숨김
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else if offsetDifference < -scrollThreshold {
            // 스크롤이 위로 일정 이상 이동한 경우 네비게이션 바 나타냄
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
        previousScrollOffset = currentOffset
    }
}
