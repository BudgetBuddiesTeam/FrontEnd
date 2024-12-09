//
//  NoticeTableViewCell.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 11/25/24.
//

import UIKit
import SnapKit

class NoticeTableViewCell: UITableViewCell {
    static let identifier = "NoticeTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "공지사항"
        label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 12)
        label.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "개인정보 처리방침 변경 예정"
        label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
        label.textColor = .black
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "0월 0일"
        label.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 12)
        label.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        [titleLabel, contentLabel, dateLabel].forEach {
            self.addSubview($0)
        }
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        contentLabel.snp.makeConstraints { 
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

extension NoticeTableViewCell {
    func configure(title: String, content: String, date: String) {
        titleLabel.text = title
        contentLabel.text = content
        dateLabel.text = date
    }
}
