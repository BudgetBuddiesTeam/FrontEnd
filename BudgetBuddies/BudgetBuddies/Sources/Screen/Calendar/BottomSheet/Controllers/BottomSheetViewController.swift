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
  private let bottomSheet = BottomSheet()

  private var bottomSheetTopConstraint: Constraint?
  private var bottomSheetBottomConstraint: Constraint?

  private var bottomSheetValue: CGFloat {
    return self.view.bounds.height * 0.225  // bottomSheet이 올라오는 비율
  }

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

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
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
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
      
      let tableViewTabGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTableView))
      bottomSheet.commentsTableView.addGestureRecognizer(tableViewTabGesture)
      bottomSheet.commentsTableView.isUserInteractionEnabled = true
      
  }

  // MARK: - Set up TableView
  private func setupTableView() {
    // 셀 등록
    bottomSheet.commentsTableView.backgroundColor = .clear
    bottomSheet.commentsTableView.register(
      CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)

    bottomSheet.commentsTableView.delegate = self
    bottomSheet.commentsTableView.dataSource = self

    bottomSheet.commentsTableView.allowsSelection = true
    bottomSheet.commentsTableView.showsVerticalScrollIndicator = false
    bottomSheet.commentsTableView.separatorStyle = .none
  }

  // MARK: - Set up TextView
  private func setupTextView() {
    bottomSheet.commentTextView.delegate = self
    bottomSheet.commentTextView.text = "댓글을 입력해 주세요"
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

  @objc
  func didTapSendButton() {
    self.bottomSheet.endEditing(true)
    // 플레이스홀더 재배치
    bottomSheet.commentTextView.text = "댓글을 입력해 주세요"
    bottomSheet.commentTextView.textColor = BudgetBuddiesAsset.AppColor.textExample.color
    bottomSheet.updateTextViewHeight()
    // 여기서 댓글 post?아마
  }
}
// MARK: - UITableView DataSource
extension BottomSheetViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2  // 일단 10개
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let commentCell =
      bottomSheet.commentsTableView.dequeueReusableCell(
        withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell

    commentCell.delegate = self

    commentCell.selectionStyle = .none
    return commentCell
  }
}

// MARK: - UITableView Delegate
extension BottomSheetViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    self.view.endEditing(true)
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

// MARK: - CommentCell Delegate
extension BottomSheetViewController: CommentCellDelegate {
  func didTapEditButton(in cell: CommentCell) {
    AlertManager.showAlert(on: self, title: "댓글을 수정하시겠습니까?", message: nil, needsCancelButton: true)
  }

  func didTapDeleteButton(in cell: CommentCell) {
    AlertManager.showAlert(on: self, title: "댓글을 삭제하시겠습니까?", message: nil, needsCancelButton: true)
  }

}
