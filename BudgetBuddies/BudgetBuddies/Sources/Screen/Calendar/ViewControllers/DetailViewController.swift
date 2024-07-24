//
//  DetailViewController.swift
//  BudgetBuddiesLocal
//
//  Created by 김승원 on 7/17/24.
//

import UIKit

final class DetailViewController: UIViewController {
  enum InfoType {
    case discount
    case support
  }

  // MARK: - Properties
  let tableView = UITableView()

  var infoType: InfoType

  // 네비게이션 바
  private var previousScrollOffset: CGFloat = 0.0
  private let scrollThreshold: CGFloat = 10.0  // 네비게이션 바가 나타나거나 사라질 스크롤 오프셋 차이

  // MARK: - Life Cycle ⭐️
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

    setupTableView()
    setupNavigationBar()
  }

  // MARK: - Set up TableView
  private func setupTableView() {
    self.view.backgroundColor = #colorLiteral(
      red: 0.97647053, green: 0.97647053, blue: 0.97647053, alpha: 1)
    tableView.backgroundColor = .clear
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    tableView.showsVerticalScrollIndicator = false
    tableView.scrollsToTop = true

    tableView.dataSource = self
    tableView.delegate = self

    tableView.register(InformationCell.self, forCellReuseIdentifier: "InfomationCell")

    self.view.addSubview(tableView)
    setupTableViewConstraints()
  }

  private func setupTableViewConstraints() {
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  // MARK: - Set up NavigationBar
  private func setupNavigationBar() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithDefaultBackground()
    appearance.shadowColor = nil

    navigationController?.navigationBar.backgroundColor = #colorLiteral(
      red: 0.97647053, green: 0.97647053, blue: 0.97647053, alpha: 1)
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    navigationController?.navigationBar.isHidden = false

    // 백 버튼
    lazy var backButton: UIBarButtonItem = {
      let btn = UIBarButtonItem(
        image: UIImage(named: "backButtonImage")?.withRenderingMode(.alwaysOriginal),
        style: .done,
        target: self,
        action: #selector(didTapBarButtonItem))
      return btn
    }()
    navigationItem.leftBarButtonItem = backButton

    if let font = UIFont(name: "Pretendard-SemiBold", size: 18) {
      appearance.titleTextAttributes = [
        .font: font,
        .kern: -2.5,
      ]
    }
  }
}

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = UITableViewCell()
      cell.backgroundColor = .clear
      return cell
    }

    let informationCell =
      tableView.dequeueReusableCell(withIdentifier: "InfomationCell", for: indexPath)
      as! InformationCell
    switch infoType {
    case .discount:
      let infoType: InformationCell.InfoType = .discount
      informationCell.configure(infoType: infoType)

      informationCell.infoTitleLabel.text = "지그재그 썸머세일"
      informationCell.dateLabel.text = "08.17 ~ 08.20"
      informationCell.percentLabel.text = "~80%"
      informationCell.urlString = "https://www.naver.com"

      informationCell.delegate = self

      return informationCell
    case .support:
      let infoType: InformationCell.InfoType = .support
      informationCell.configure(infoType: infoType)

      informationCell.infoTitleLabel.text = "국가장학금 1차 신청"
      informationCell.dateLabel.text = "08.17 ~ 08.20"
      informationCell.urlString = "https://www.google.com"

      informationCell.delegate = self

      return informationCell
    }
  }

  // MARK: - Selectors
  @objc private func didTapBarButtonItem() {
    print(#function)
    self.navigationController?.popViewController(animated: true)
  }
}

// MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return 30
    }

    return 168
  }

  // MARK: - 스크롤 애니메이션
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

// MARK: - InfomationCell Delegate
extension DetailViewController: InformationCellDelegate {
  func didTapWebButton(in cell: InformationCell, urlString: String) {
    print("커스텀 델리게이트, 뷰컨에서 받음")

    let vc = WebViewController(with: urlString)
    let nav = UINavigationController(rootViewController: vc)
    nav.modalPresentationStyle = .fullScreen
    self.present(nav, animated: true, completion: nil)
  }
}
