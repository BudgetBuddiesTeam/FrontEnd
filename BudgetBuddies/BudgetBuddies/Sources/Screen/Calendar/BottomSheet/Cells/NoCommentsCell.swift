//
//  NoCommentsCell.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/17/24.
//

import UIKit
import SnapKit

class NoCommentsCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "NoCommentCell"
    
    // MARK: - UIComponents
    var noCommentsLabel: UILabel = {
        let lb = UILabel()
        lb.text = "아직 댓글이 없어요"
        lb.font = BudgetBuddiesFontFamily.Pretendard.regular.font(size: 14)
        lb.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
        lb.textAlignment = .center
        lb.setCharacterSpacing(-0.35)
        return lb
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.backgroundColor = .clear
        self.contentView.addSubviews(noCommentsLabel)
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        self.contentView.snp.makeConstraints { make in
            make.height.equalTo(128)
            make.leading.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        noCommentsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(107)
            make.centerX.equalToSuperview()
            make.height.equalTo(21)
            make.width.equalTo(self.bounds.width)
        }
    }
}
