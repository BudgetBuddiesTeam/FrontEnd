//
//  commentCell.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/1/24.
//

import SnapKit
import UIKit

protocol CommentCellDelegate: AnyObject {
  func didTapEditButton(in cell: CommentCell)
  func didTapDeleteButton(in cell: CommentCell)
}

class CommentCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "CommentCell"

  weak var delegate: CommentCellDelegate?
    
    var discountsCommentsContent: DiscountsCommentsContent? {
        didSet {
            guard let discountsCommentsContent = self.discountsCommentsContent else { return }
            self.userName.text = "익명" + String(discountsCommentsContent.anonymousNumber)
            self.commentLabel.text = discountsCommentsContent.content
        }
    }
    
    var supportsCommentsContent: SupportsCommentsContent? {
        didSet {
            guard let supportsCommentsContent = self.supportsCommentsContent else { return }
            self.userName.text = "익명" + String(supportsCommentsContent.anonymousNumber)
            self.commentLabel.text = supportsCommentsContent.content
        }
    }

    // MARK: - UI Components
  // 익명1, 2, 3...
  var userName: UILabel = {
    let lb = UILabel()
    lb.text = "익명0"
    lb.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 14)
    lb.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    lb.setCharacterSpacing(-0.35)
    lb.textAlignment = .left
    return lb
  }()

  // 댓글 라벨
  var commentLabel: UILabel = {
    let lb = UILabel()
    lb.text = "댓글을 불러오는 중입니다..."
    lb.font = BudgetBuddiesFontFamily.Pretendard.regular.font(size: 14)
    lb.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
    lb.setCharacterSpacing(-0.35)
    lb.textAlignment = .left
    lb.numberOfLines = 0
    return lb
  }()

  // stackView
  lazy var stackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [userName, commentLabel])
    sv.axis = .vertical
    sv.spacing = 2
    sv.alignment = .fill
    sv.distribution = .fill
    return sv
  }()

  // 댓글 수정, 삭제 버튼
  // 백뷰
  var buttonBackView: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.textBox.color
    view.layer.masksToBounds = true
    view.layer.cornerRadius = 3
    return view
  }()

  // 버튼 구분 선
  var verticalSeparator: UIView = {
    let view = UIView()
    view.backgroundColor = BudgetBuddiesAsset.AppColor.circleStroke.color
    return view
  }()

  // 수정 버튼 (지우개)
  lazy var editButtonImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(systemName: "eraser.fill")
    iv.contentMode = .scaleAspectFit
    iv.tintColor = BudgetBuddiesAsset.AppColor.textExample.color

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapEditButton))
    iv.addGestureRecognizer(tapGesture)
    iv.isUserInteractionEnabled = true

    return iv
  }()

  // 삭제 버튼 (휴지통)
  lazy var deleteButtonImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(systemName: "trash.fill")
    iv.contentMode = .scaleAspectFit
    iv.tintColor = BudgetBuddiesAsset.AppColor.textExample.color

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDeleteButton))
    iv.addGestureRecognizer(tapGesture)
    iv.isUserInteractionEnabled = true

    return iv
  }()

  // MARK: - init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)

    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Set up UI
  private func setupUI() {
    self.contentView.addSubviews(stackView, buttonBackView)
    buttonBackView.addSubviews(verticalSeparator, editButtonImageView, deleteButtonImageView)

    setupConstraints()
  }

  // MARK: - Set up Constraints
  private func setupConstraints() {
    userName.snp.makeConstraints { make in
      make.height.equalTo(18)
    }

    stackView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(23)
      make.bottom.equalToSuperview().inset(17)
        make.leading.trailing.equalToSuperview().inset(22)
    }

    buttonBackView.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(22)
      make.centerY.equalTo(userName)
      make.height.equalTo(18)
      make.width.equalTo(62)
    }

    verticalSeparator.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(5)
      make.centerX.equalToSuperview()
      make.width.equalTo(1)
    }

    editButtonImageView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.trailing.equalTo(verticalSeparator.snp.leading).offset(-10)
      make.height.width.equalTo(13)
    }

    deleteButtonImageView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalTo(verticalSeparator.snp.trailing).offset(10)
      make.height.width.equalTo(13)
    }
  }
  // MARK: - Selectors
  @objc
  private func didTapEditButton() {
    delegate?.didTapEditButton(in: self)
  }

  @objc func didTapDeleteButton() {
    delegate?.didTapDeleteButton(in: self)
  }
}
