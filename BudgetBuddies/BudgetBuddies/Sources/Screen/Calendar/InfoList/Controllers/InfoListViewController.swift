//
//  InfoListViewController.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/26/24.
//

import SnapKit
import UIKit

final class InfoListViewController: UIViewController {
  // MARK: - Properties

  var infoType: InfoType

  var previousScrollOffset: CGFloat = 0.0
  var scrollThreshold: CGFloat = 10.0  // 네비게이션 바가 나타나거나 사라질 스크롤 오프셋 차이

  // networking
  var supportInfoManager = SupportInfoManager.shared
  var discountInfoManager = DiscountInfoManager.shared
  var supports: [SupportContent] = []
  var discounts: [DiscountContent] = []
  var infoRequest: InfoRequest?

  // 전달받을 년월
  var yearMonth: YearMonth? {  // didSet 지워도 ok
    didSet {
      guard let yearMonth = yearMonth else { return }
      print("InfoListViewController: \(yearMonth)")
    }
  }

  // MARK: - UI Components
  lazy var tableView = UITableView()

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
    print("InfoListViewController: \(#function)")

    setupData()
    setupNavigationBar()
    setupTableView()
  }
  // MARK: - Set up Data
  private func setupData() {
    // 할인정보, 지원정보 request는 동일
    print("InfoListViewController: \(#function)")
    guard let yearMonth = self.yearMonth else { return }
    guard let year = yearMonth.year else { return }
    guard let month = yearMonth.month else { return }
    print("InfoListViewController: \(year)년 \(month)월")

    self.infoRequest = InfoRequest(year: year, month: month, page: 0, size: 10)
    guard let infoRequest = self.infoRequest else { return }

    switch infoType {
    case .discount:
      print("--------------할인정보 불러오기--------------")
      discountInfoManager.fetchDiscounts(request: infoRequest) { result in
        switch result {
        case .success(let response):
          print("데이터 디코딩 성공")
          self.discounts = response.content

          DispatchQueue.main.async {
            self.tableView.reloadData()
          }

        case .failure(let error):
          print("데이터 디코딩 실패")
          print(error.localizedDescription)
        }
      }

    case .support:
      print("--------------지원정보 불러오기--------------")

      supportInfoManager.fetchSupports(request: infoRequest) { result in
        switch result {
        case .success(let response):
          print("데이터 디코딩 성공")
          self.supports = response.content

          DispatchQueue.main.async {
            self.tableView.reloadData()
          }

        case .failure(let error):
          print("데이터 디코딩 실패")
          print(error.localizedDescription)

        }
      }
    }

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
      .foregroundColor: BudgetBuddiesAsset.AppColor.textBlack.color,
      .kern: -0.45,
    ]

    appearance.titleTextAttributes = titleAttributes

    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    navigationController?.navigationBar.isHidden = false

    // 백 버튼
    lazy var backButton: UIBarButtonItem = {
      let btn = UIBarButtonItem(
        image: UIImage(systemName: "chevron.left"),
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
    tableView.allowsSelection = true
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
    switch infoType {

    case .discount:
      let discountsCount = self.discounts.count
      return discountsCount + 1  // 제일 위에 빈 셀 포함

    case .support:
      let supportsCount = self.supports.count
      return supportsCount + 1  // 제일 위에 빈 셀 포함
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = UITableViewCell()
      cell.backgroundColor = .clear
      return cell

    } else {
      switch infoType {
      case .discount:  // 할인정보
        let informationCell =
          tableView.dequeueReusableCell(withIdentifier: InformationCell.identifier, for: indexPath)
          as! InformationCell
        informationCell.configure(infoType: .discount)

        // 대리자 설정
        informationCell.delegate = self

        // 데이터 전달
        let discount = discounts[indexPath.row - 1]
        informationCell.discount = discount

        // 자간 조절
        informationCell.infoTitleLabel.setCharacterSpacing(-0.4)
        informationCell.dateLabel.setCharacterSpacing(-0.3)
        informationCell.percentLabel.setCharacterSpacing(-0.3)

        informationCell.selectionStyle = .none
        return informationCell

      case .support:  // 지원정보
        let informationCell =
          tableView.dequeueReusableCell(withIdentifier: InformationCell.identifier, for: indexPath)
          as! InformationCell
        informationCell.configure(infoType: .support)

        // 대리자 설정
        informationCell.delegate = self

        // 데이터 전달
        let support = supports[indexPath.row - 1]
        informationCell.support = support

        // 자간 조절
        informationCell.infoTitleLabel.setCharacterSpacing(-0.4)
        informationCell.dateLabel.setCharacterSpacing(-0.3)

        informationCell.selectionStyle = .none
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

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row != 0 {
      let vc = BottomSheetViewController()
      vc.modalPresentationStyle = .overFullScreen
      self.present(vc, animated: true, completion: nil)
    }
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let currentOffset = scrollView.contentOffset.y
    let offsetDifference = currentOffset - previousScrollOffset

    if currentOffset <= 0 {  // 스크롤을 완전히 위로 올렸을 때 네비게이션 바 나타냄
      navigationController?.setNavigationBarHidden(false, animated: true)

    } else if offsetDifference > scrollThreshold {  // 스크롤이 아래로 일정 이상 이동한 경우 네비게이션 바 숨김
      navigationController?.setNavigationBarHidden(true, animated: true)

    } else if offsetDifference < -scrollThreshold {  // 스크롤이 위로 일정 이상 이동한 경우 네비게이션 바 나타냄
      navigationController?.setNavigationBarHidden(false, animated: true)

    }

    previousScrollOffset = currentOffset
  }
}

// MARK: - InformationCell Delegate
extension InfoListViewController: InformationCellDelegate {
  // informationCell: 사이트 바로가기 버튼이 눌리는 시점
  func didTapWebButton(in cell: InformationCell, urlString: String) {
    guard let url = URL(string: urlString) else {
      print("Error: 유효하지 않은 url \(urlString)")
      return
    }

    // 외부 웹사이트로 이동
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
}
