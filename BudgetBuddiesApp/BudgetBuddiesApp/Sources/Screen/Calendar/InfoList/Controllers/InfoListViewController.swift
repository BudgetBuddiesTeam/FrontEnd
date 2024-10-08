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
  var infoRequest: InfoRequestDTO?

  var commentManager = CommentManager.shared

  // 전달받을 년월
  var yearMonth: YearMonth? {  // didSet 지워도 ok
    didSet {
      guard let yearMonth = yearMonth else { return }
      print("InfoListViewController: \(yearMonth)")
    }
  }

  // MARK: - UI Components
  // 테이블 뷰
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
    setupTitle()
    setupNavigationBar()
    setupTableView()
  }

  // 탭바에 가려지는 요소 보이게 하기
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.tableView.contentInset.bottom = 15
  }

  // MARK: - Set up Title
  private func setupTitle() {
    guard let yearMonth = self.yearMonth else { return }
    guard let month = yearMonth.month else { return }

    switch infoType {
    case .discount:
      self.title = "\(month)월 할인정보"
    case .support:
      self.title = "\(month)월 지원정보"
    }
  }

  // MARK: - Set up Data
  private func setupData() {
    // 할인정보, 지원정보 request는 동일
    print("InfoListViewController: \(#function)")
    guard let yearMonth = self.yearMonth else { return }
    guard let year = yearMonth.year else { return }
    guard let month = yearMonth.month else { return }
    print("InfoListViewController: \(year)년 \(month)월")

    self.infoRequest = InfoRequestDTO(year: year, month: month, page: 0, size: 10)
    guard let infoRequest = self.infoRequest else { return }

    switch infoType {
    case .discount:
      print("--------------할인정보 불러오기--------------")
      discountInfoManager.fetchDiscounts(request: infoRequest) { result in
        switch result {
        case .success(let response):
          print("데이터 디코딩 성공")
          self.discounts = response.result.content

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
          self.supports = response.result.content

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
    self.setupDefaultNavigationBar(backgroundColor: .clear)
    // 뒤로가기 제스처 추가
    self.navigationController?.interactivePopGestureRecognizer?.delegate = self

    navigationController?.navigationBar.isHidden = false

    // 백 버튼
    addBackButton(selector: #selector(didTapBarButtonItem))
  }

  // MARK: - Set up TableView
  private func setupTableView() {
    self.view.backgroundColor = BudgetBuddiesAppAsset.AppColor.background.color
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
      cell.selectionStyle = .none
      return cell
    }

    if indexPath.row >= 1 {
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

        // 댓글 개수 통신
        let id = discount.id
        let request = PostCommentRequestDTO(page: 0, size: 10)

        commentManager.fetchDiscountsComments(discountInfoId: id, request: request) { result in
          switch result {
          case .success(let response):
            DispatchQueue.main.async {
              let commentCount = response.result.content.count
              informationCell.commentCount = commentCount
            }
          case .failure(let error):
            print(error.localizedDescription)
          }
        }

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

        // 댓글 개수 통신
        let id = support.id
        let request = PostCommentRequestDTO(page: 0, size: 10)

        commentManager.fetchSupportsComments(supportsInfoId: id, request: request) { result in
          switch result {
          case .success(let response):
            DispatchQueue.main.async {
              let commentCount = response.result.content.count
              informationCell.commentCount = commentCount
            }
          case .failure(let error):
            print(error.localizedDescription)
          }
        }

        // 자간 조절
        informationCell.infoTitleLabel.setCharacterSpacing(-0.4)
        informationCell.dateLabel.setCharacterSpacing(-0.3)

        informationCell.selectionStyle = .none
        return informationCell
      }
    }

    return UITableViewCell()
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
    if indexPath.row >= 1 {
      switch self.infoType {
      case .discount:
        let infoId = self.discounts[indexPath.row - 1].id
        let vc = BottomSheetViewController(infoType: .discount, infoId: infoId)
        vc.modalPresentationStyle = .overFullScreen

        //대리자 설정
        vc.delegate = self

        self.present(vc, animated: true, completion: nil)

      case .support:
        let infoId = self.supports[indexPath.row - 1].id
        let vc = BottomSheetViewController(infoType: .support, infoId: infoId)
        vc.modalPresentationStyle = .overFullScreen

        //대리자 설정
        vc.delegate = self

        self.present(vc, animated: true, completion: nil)
      }
    }
  }

  // MARK: - ScrollView Delegate
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
  // 좋아요 눌리는 시점
  func didTapLikesButton(in cell: InformationCell, likesCount: Int, infoType: InfoType, infoId: Int)
  {
    print("좋아요 눌린: \(infoId)")
    print("InfoListViewController: 좋아요 눌림")
    switch infoType {
    case .discount:
      discountInfoManager.postDiscountsLikes(userId: 1, discountInfoId: infoId) { result in
        switch result {
        case .success(let response):
          print("좋아요 성공")

          if response.result.likeCount > likesCount {
            AlertManager.showAlert(
              on: self, title: "추천하시겠습니까?", message: nil, needsCancelButton: true
            ) { _ in
              self.setupData()
            }

          } else {
            AlertManager.showAlert(
              on: self, title: "추천을 취소하시겠습니까?", message: nil, needsCancelButton: true
            ) { _ in
              self.setupData()
            }
          }

        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    case .support:
      supportInfoManager.postSupportsLikes(userId: 1, supportInfoId: infoId) { result in
        switch result {
        case .success(let response):
          print("좋아요 성공")

          if response.result.likeCount > likesCount {
            AlertManager.showAlert(
              on: self, title: "추천하시겠습니까?", message: nil, needsCancelButton: true
            ) { _ in
              self.setupData()
            }

          } else {
            AlertManager.showAlert(
              on: self, title: "추천을 취소하시겠습니까?", message: nil, needsCancelButton: true
            ) { _ in
              self.setupData()
            }
          }

        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }

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

// MARK: - BottomSheetViewController Delegate
extension InfoListViewController: BottomSheetViewControllerDelegate {
  func didBottomSheetViewControllerDismissed() {
    setupData()
  }
}

// MARK: - 뒤로 가기 슬라이드 제스처 추가
extension InfoListViewController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
