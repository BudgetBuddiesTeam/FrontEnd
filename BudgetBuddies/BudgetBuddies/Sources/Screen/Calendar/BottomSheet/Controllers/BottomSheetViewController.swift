//
//  BottomSheetViewController.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/27/24.
//

import SnapKit
import UIKit

final class BottomSheetViewController: DimmedViewController {
  // MARK: - Properties
  var infoType: InfoType
  var infoId: Int
    
    // 댓글 수정 중인지 판단하는 변수
    var nowModify: Bool = false {
        didSet {
            if nowModify {
                print("댓글 수정 시작")
                // 키보드 올리기
                self.bottomSheet.commentTextView.becomeFirstResponder()
                
            } else {
                print("댓글 수정 취소")
            }
        }
    }

  let textViewPrompt = "댓글을 입력해 주세요"

  private let bottomSheet = BottomSheet()

  private var bottomSheetTopConstraint: Constraint?
  private var bottomSheetBottomConstraint: Constraint?

  private var bottomSheetValue: CGFloat {
    return self.view.bounds.height * 0.225  // bottomSheet이 올라오는 비율
  }

  // networking
  var commentManager = CommentManager.shared
  var discountsComments: [DiscountsCommentsContent] = []
  var supportsComments: [SupportsCommentsContent] = []
  var userId: Int = 1  // 일단 하드 코딩
  var commentRequest: PostCommentRequest?

  // MARK: - Life Cycle
  init(infoType: InfoType, infoId: Int) {
    self.infoType = infoType
    self.infoId = infoId
    super.init()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupData()
    setupUI()
    setupButtons()
    setupTapGestures()
    setupPanGesture()
    setupTableView()
    setupTextView()
    registerKeyboardNotifications()
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
      
      modifyCancled()
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }
    
    // MARK: - modify canceled
    private func modifyCancled() {
        if self.nowModify {
            self.nowModify = false
            self.bottomSheet.commentTextView.text = textViewPrompt
            self.bottomSheet.commentTextView.textColor = BudgetBuddiesAsset.AppColor.textExample.color
            self.bottomSheet.updateTextViewHeight()
        }
    }

  // MARK: - Set up Data
  private func setupData() {
    print("BottomSheetViewController: \(#function)")
    self.commentRequest = PostCommentRequest(page: 0, size: 20)  // 일단 20개만 불러오기
    guard let commentRequest = self.commentRequest else { return }

    switch self.infoType {
    case .discount:
      print("----------- 할인정보 댓글 불러오기 ------------")
      // 임시로 댓글 아이디 1
      commentManager.fetchDiscountsComments(discountInfoId: self.infoId, request: commentRequest) {
        result in
        switch result {
        case .success(let response):
          print("데이터 디코딩 성공")
          self.discountsComments = response.result.content

          DispatchQueue.main.async {
            self.bottomSheet.commentsTableView.reloadData()
          }

        case .failure(let error):
          print("데이터 디코딩 실패")
          print(error.localizedDescription)
        }
      }
    case .support:
      print("----------- 지원정보 댓글 불러오기 ------------")
      commentManager.fetchSupportsComments(supportsInfoId: self.infoId, request: commentRequest) {
        result in
        switch result {
        case .success(let response):
          print("데이터 디코딩 성공")
          self.supportsComments = response.result.content

          DispatchQueue.main.async {
            self.bottomSheet.commentsTableView.reloadData()
          }

        case .failure(let error):
          print("데이터 디코딩 실패")
          print(error.localizedDescription)
        }
      }
    }

  }

  // MARK: - Set up UI
  private func setupUI() {
    self.view.addSubview(bottomSheet)

    setupConstraint()
  }

  // MARK: - Set up Constraints
  private func setupConstraint() {
    bottomSheet.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      bottomSheetTopConstraint =
        make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(bottomSheetValue).constraint
      bottomSheetBottomConstraint = make.bottom.equalTo(view.snp.bottom).inset(0).constraint
    }
  }

  // MARK: - Set up Buttons
  private func setupButtons() {
    bottomSheet.sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
  }

  // MARK: - Set up Pan Gesture
  private func setupPanGesture() {
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
    bottomSheet.addGestureRecognizer(panGesture)
  }

  // MARK: - Set up TapGesture
  private func setupTapGestures() {
    // bottomSheet 자체 Tap
    self.view.isUserInteractionEnabled = true
    let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
    view.addGestureRecognizer(viewTapGesture)

    // 뒷 배경만을 눌렀을 경우에 dismiss가 되도록
    // bottomSheet에 temp gesture 설정
    // 다른 방법이 있다면 추후에 수정할 예정
    bottomSheet.isUserInteractionEnabled = true
    let tempTapGesture = UITapGestureRecognizer(target: self, action: nil)
    tempTapGesture.cancelsTouchesInView = false  // 터치 겹치지 않게
    bottomSheet.addGestureRecognizer(tempTapGesture)

    let tableViewTabGesture = UITapGestureRecognizer(
      target: self, action: #selector(didTapTableView))
    bottomSheet.commentsTableView.addGestureRecognizer(tableViewTabGesture)
    bottomSheet.commentsTableView.isUserInteractionEnabled = true

  }

  // MARK: - Set up TableView
  private func setupTableView() {
    // 셀 등록
    registerCells()

    bottomSheet.commentsTableView.backgroundColor = .clear

    bottomSheet.commentsTableView.delegate = self
    bottomSheet.commentsTableView.dataSource = self

    bottomSheet.commentsTableView.allowsSelection = true
    bottomSheet.commentsTableView.showsVerticalScrollIndicator = false
    bottomSheet.commentsTableView.separatorStyle = .none
  }

  // MARK: - Register Cells
  private func registerCells() {
    bottomSheet.commentsTableView.register(
      CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)

    bottomSheet.commentsTableView.register(
      NoCommentsCell.self, forCellReuseIdentifier: NoCommentsCell.identifier)
  }

  // MARK: - Set up TextView
  private func setupTextView() {
    bottomSheet.commentTextView.delegate = self
    bottomSheet.commentTextView.text = textViewPrompt
  }

  // MARK: - register Keyboard Notification
  private func registerKeyboardNotifications() {
    NotificationCenter.default.addObserver(
      self, selector: #selector(keyboardWillShow(_:)),
      name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(
      self, selector: #selector(keyboardWillHide(_:)),
      name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  // MARK: - Selectors
  @objc
  private func didTapView() {
    self.dismiss(animated: true, completion: nil)
  }

  @objc
  private func keyboardWillShow(_ notification: Notification) {
    guard let userInfo = notification.userInfo,
      let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
    else { return }

    let keyboardHeight = keyboardFrame.height
    UIView.animate(withDuration: 0.3) {
      self.bottomSheetBottomConstraint?.update(offset: -keyboardHeight)
      self.bottomSheetTopConstraint?.update(inset: 0)
      self.view.layoutIfNeeded()
    }
  }

  @objc
  private func keyboardWillHide(_ notification: Notification) {
    UIView.animate(withDuration: 0.3) {
      self.bottomSheetBottomConstraint?.update(offset: 0)  // 원래 위치로 복원
      self.view.layoutIfNeeded()
    }
  }

  @objc
  private func didTapTableView() {
    self.view.endEditing(true)
      modifyCancled()
  }

  // MARK: - Handle PanGesture
  @objc
  private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: self.view)

    let screenHeight = self.view.bounds.height
    let fullScreenThreshold = screenHeight * 0.1  // 댓글창이 다 올라온 상태엥서 어느정도까지 내려야 중간상태로 바뀌는지
    let dismissThreshold = screenHeight * 0.6  // 중간 상태에서 어느정도도 내려야 dismiss

    switch gesture.state {
    case .changed:
      if let constant = bottomSheetTopConstraint?.layoutConstraints.first?.constant {
        // 스크롤 방향에 따라 오프셋 업데이트
        let newOffset = constant + translation.y  // 아래로 드래그하면 negative, 위로 드래그하면 positive

        // 오프셋을 최소 0까지 제한
        let clampedOffset = max(0, newOffset)

        self.bottomSheetTopConstraint?.update(offset: clampedOffset)
        self.view.layoutIfNeeded()

        // 스크롤 후의 위치를 gesture에 반영
        gesture.setTranslation(.zero, in: self.view)
      }

      // 중간 상태에서 아래로 스크롤 시에도 스크롤에 따라 댓글창 이동
      if let constant = bottomSheetTopConstraint?.layoutConstraints.first?.constant {
        if constant > fullScreenThreshold {
          // 특정 높이까지 내려오면 dismiss
          if constant > dismissThreshold {
            self.dismiss(animated: true, completion: nil)
          }
        }
      }

    case .ended:
      UIView.animate(withDuration: 0.3) {
        if let constant = self.bottomSheetTopConstraint?.layoutConstraints.first?.constant {
          if constant > fullScreenThreshold {
            // 댓글창이 다 올라온 상태에서 내려가면 원위치로
            self.bottomSheetTopConstraint?.update(offset: self.bottomSheetValue)
          } else {
            // 댓글창이 중간 상태일 때 dismiss 여부 결정
            if constant > dismissThreshold {
              self.dismiss(animated: true, completion: nil)
            } else {
              self.bottomSheetTopConstraint?.update(offset: 0)
            }
          }
        }
        self.view.layoutIfNeeded()
      }

    default:
      break
    }
  }

  // MARK: - 댓글 POST, PUT ⭐️
  @objc
  func didTapSendButton() {
    self.bottomSheet.endEditing(true)
      
      if self.nowModify {
          // 수정 중이면 PUT
          // 👋🏻
          
          self.nowModify = false
          print("댓글 수정 완료")
          
      } else {
          // 수정 중이 아니면 POST
          switch self.infoType {
          case .discount:
            postDiscountsComments()

          case .support:
            postSupportsComments()
          }
      }

    // 플레이스홀더 재배치
    bottomSheet.commentTextView.text = textViewPrompt
    bottomSheet.commentTextView.textColor = BudgetBuddiesAsset.AppColor.textExample.color
    bottomSheet.updateTextViewHeight()
  }

  // MARK: - Discount, Support Comments Post
    // 추후에 빈 텍스트 뷰 확인하는 코드를 위에 함수에 옮겨서 하나로 관리
  private func postDiscountsComments() {
    guard let textContent = bottomSheet.commentTextView.text,
      bottomSheet.commentTextView.text != textViewPrompt
    else {
      print("댓글 생성 실패: 빈 텍스트 뷰")
      return
    }

    print("\(self.infoType)셀의 \(infoId)번 게시물 댓글: \(bottomSheet.commentTextView.text!)")
    let discountsCommentsRequestDTO = DiscountsCommentsRequestDTO(
      content: textContent, discountInfoID: self.infoId)

    commentManager.postDiscountsComments(userId: self.userId, request: discountsCommentsRequestDTO)
    { result in
      switch result {
      case .success(let response):
        print("\(self.infoType)셀의 \(self.infoId)번 게시물 statusCode: \(response.statusCode)")

        self.setupData()

      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }

  private func postSupportsComments() {
    guard let textContent = bottomSheet.commentTextView.text,
      bottomSheet.commentTextView.text != textViewPrompt
    else {
      print("댓글 생성 실패: 빈 텍스트 뷰")
      return
    }

    print("\(self.infoType)셀의 \(infoId)번 게시물 댓글: \(bottomSheet.commentTextView.text!)")
    let supportsCommentsRequestDTO = SupportsCommentsRequestDTO(
      content: textContent, supportInfoID: self.infoId)

    commentManager.postSupportsComments(userId: self.userId, request: supportsCommentsRequestDTO) {
      result in
      switch result {
      case .success(let response):
        print("\(self.infoType)셀의 \(self.infoId)번 게시물 statusCode: \(response.statusCode)")

        self.setupData()

      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}

// MARK: - UITableView DataSource
extension BottomSheetViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    let commentsCount: Int

    switch self.infoType {
    case .discount:
      commentsCount = self.discountsComments.count == 0 ? 1 : self.discountsComments.count
    case .support:
      commentsCount = self.supportsComments.count == 0 ? 1 : self.supportsComments.count
    }

    return commentsCount
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    switch self.infoType {
    case .discount:
      if indexPath.row < self.discountsComments.count {
        let commentCell =
          bottomSheet.commentsTableView.dequeueReusableCell(
            withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell

        // 대리자
        commentCell.delegate = self

        // 데이터 전달
        commentCell.discountsCommentsContent = self.discountsComments[indexPath.row]

        // configure
        commentCell.configure(userId: self.userId)

        commentCell.selectionStyle = .none
        return commentCell

      } else {
        let noCommentCell =
          bottomSheet.commentsTableView.dequeueReusableCell(
            withIdentifier: NoCommentsCell.identifier, for: indexPath) as! NoCommentsCell

        noCommentCell.selectionStyle = .none
        return noCommentCell
      }

    case .support:
      if indexPath.row < self.supportsComments.count {
        let commentCell =
          bottomSheet.commentsTableView.dequeueReusableCell(
            withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell

        // 대리자
        commentCell.delegate = self

        // 데이터 전달
        commentCell.supportsCommentsContent = self.supportsComments[indexPath.row]

        // configure
        commentCell.configure(userId: self.userId)

        commentCell.selectionStyle = .none
        return commentCell

      } else {
        let noCommentCell =
          bottomSheet.commentsTableView.dequeueReusableCell(
            withIdentifier: NoCommentsCell.identifier, for: indexPath) as! NoCommentsCell

        noCommentCell.selectionStyle = .none
        return noCommentCell
      }
    }
  }
}

// MARK: - UITableView Delegate
extension BottomSheetViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

  }
}

// MARK: - TextView Delegate
extension BottomSheetViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    bottomSheet.updateTextViewHeight()
  }

  func textViewDidBeginEditing(_ textView: UITextView) {
    if bottomSheet.commentTextView.textColor == BudgetBuddiesAsset.AppColor.textExample.color {
      bottomSheet.commentTextView.text = ""
      bottomSheet.commentTextView.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    }
  }

  func textViewDidEndEditing(_ textView: UITextView) {
    if bottomSheet.commentTextView.text.isEmpty {
      bottomSheet.commentTextView.text = "댓글을 입력해 주세요"
      bottomSheet.commentTextView.textColor = BudgetBuddiesAsset.AppColor.textExample.color
    }
  }
}

// MARK: - CommentCell Delegate ⭐️
extension BottomSheetViewController: CommentCellDelegate {
    // 댓글 수정 버튼 눌리는 시점
  func didTapEditButton(in cell: CommentCell, commentId: Int) {
    AlertManager.showAlert(on: self, title: "댓글을 수정하시겠습니까?", message: nil, needsCancelButton: true)
    { _ in
      print("\(self.infoType) 댓글 commentId: \(commentId)")
      switch self.infoType {
      case .discount:
          
        self.commentManager.getOneDiscountsComments(commentId: commentId) { result in
            
          switch result {
          case .success(let response):
              dump(response.result)
              print("수정할 댓글 content: \(response.result.content)")
              self.nowModify = true
              
              // 수정할 content를 TextView에 올리기
              DispatchQueue.main.async {
                  self.bottomSheet.commentTextView.text = response.result.content
              }
              
          case .failure(let error):
            print(error.localizedDescription)
          }
        }
          
      case .support:
        
          self.commentManager.getOneSupportsComments(commentId: commentId) { result in
              
              switch result {
              case .success(let response):
                  dump(response.result)
                  print("수정할 댓글 content: \(response.result.content)")
                  self.nowModify = true
                  
                  // 수정할 content를 TextView에 올리기
                  DispatchQueue.main.async {
                      self.bottomSheet.commentTextView.text = response.result.content
                  }
                  
              case .failure(let error):
                  print(error.localizedDescription)
              }
          }
      }
    }
  }

    // 댓글 삭제 버튼 눌리는 시점
  func didTapDeleteButton(in cell: CommentCell, commentId: Int) {
    AlertManager.showAlert(on: self, title: "댓글을 삭제하시겠습니까?", message: nil, needsCancelButton: true)
    { _ in

      // 댓글 delete ⭐️
      self.commentManager.deleteComments(commentId: commentId) { result in
        switch result {
        case .success(let response):
          print("commentId: \(commentId)번 댓글 삭제 완료 statusCode: \(response.statusCode)")

          self.setupData()

        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
}
