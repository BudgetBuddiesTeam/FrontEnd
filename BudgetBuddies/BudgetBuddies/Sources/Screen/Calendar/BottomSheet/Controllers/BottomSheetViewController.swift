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
    
    // 댓글창 애니메이션 조절 변수
    private let bottomSheetValue: CGFloat = 200 // 댓글창 올라올 위치 수치 (0에 가까울 수록 많이 올라옴)
    private let bottomSheetFullSlideValue: CGFloat = 100 // 댓글창이 다 올라온 상태에서 어느정도까지 내려야 중간상태로 바뀌는지
    private let bottomSheetHalfSlideValue: CGFloat = 50 // 댓글창이 중간까지만 올라온 상태에서 어느정도 내려야 dismiss 되는지 (터치가 기준점)

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
    
    // MARK: - Set up Buttons
    private func setupButtons() {
        bottomSheet.sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }

  // MARK: - Set up Pan Gesture
  private func setupPanGesture() {
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
    bottomSheet.addGestureRecognizer(panGesture)
  }
    
    // MARK: - Set up TableView
    private func setupTableView() {
        // 셀 등록
        bottomSheet.commentsTableView.backgroundColor = .clear
        bottomSheet.commentsTableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
        
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

  // MARK: - Set up View TapGesture
  private func setupTapGestures() {
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
  private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: BottomSheet() as UIView)
      
    switch gesture.state {
    case .changed:
      if let constant = bottomSheetTopConstraint?.layoutConstraints.first?.constant {
        let newOffset = max(0, min(bottomSheetValue, constant + translation.y))
        self.bottomSheetTopConstraint?.update(offset: newOffset)
        self.view.layoutIfNeeded()
        gesture.setTranslation(.zero, in: bottomSheet)
      }

      // 작은 상태에서 아래로 스크롤시 댓글창 닫음
      if bottomSheetTopConstraint?.layoutConstraints.first?.constant == bottomSheetValue && translation.y > bottomSheetHalfSlideValue {
        self.dismiss(animated: true, completion: nil)
        return
      }

    case .ended:
      UIView.animate(withDuration: 0.3) {
        if let constant = self.bottomSheetTopConstraint?.layoutConstraints.first?.constant,
           constant > self.bottomSheetFullSlideValue
        {
            self.bottomSheetTopConstraint?.update(offset: self.bottomSheetValue)
        } else {
          self.bottomSheetTopConstraint?.update(offset: 0)
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
        return 10 // 일단 10개
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let commentCell = bottomSheet.commentsTableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        
        commentCell.selectionStyle = .none
        return commentCell
    }
}

// MARK: - UITableView Delegate
extension BottomSheetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
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
