//
//  commentCell.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/1/24.
//

import UIKit
import SnapKit

class CommentCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "CommentCell"
    
    var userName: UILabel = {
        let lb = UILabel()
        lb.text = "익명1"
        lb.font = BudgetBuddiesFontFamily.Pretendard.semiBold.font(size: 14)
        lb.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
        lb.setCharacterSpacing(-0.35)
        lb.textAlignment = .left
        return lb
    }()
    
    var commentLabel: UILabel = {
        let lb = UILabel()
        lb.text = "이거 한 번 받으면 다시 못 받는 건가요?\n만약이러면?"
        lb.font = BudgetBuddiesFontFamily.Pretendard.regular.font(size: 14)
        lb.textColor = BudgetBuddiesAsset.AppColor.textBlack.color
        lb.setCharacterSpacing(-0.35)
        lb.textAlignment = .left
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [userName, commentLabel])
        sv.axis = .vertical
        sv.spacing = 2
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
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
        self.contentView.addSubviews(stackView)
        
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
            make.leading.trailing.equalToSuperview().inset(40)
//            make.centerX.equalToSuperview()
        }
    }
}
