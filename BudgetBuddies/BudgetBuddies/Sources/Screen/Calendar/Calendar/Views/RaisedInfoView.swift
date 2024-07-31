//
//  RaisedInfoView.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/30/24.
//

import UIKit
import SnapKit

class RaisedInfoView: UIView {
    // MARK: - Properties
    let infoType: InfoType
    
    // MARK: - UI Components
    // 왼쪽 뷰
    var leftView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 0.7, blue: 0, alpha: 1)
        return view
    }()
    
    // 타이틀
    var titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "지그재그 썸머 세일"
        lb.font = BudgetBuddiesFontFamily.Pretendard.regular.font(size: 12)
        lb.textColor = UIColor(red: 0.35, green: 0.15, blue: 0, alpha: 1)
        lb.setCharacterSpacing(-0.3)
        return lb
    }()
    
    // MARK: - init
    init(infoType: InfoType) {
        self.infoType = infoType
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.addSubviews(leftView, titleLabel)
            
        // 배경
        self.backgroundColor = BudgetBuddiesAsset.AppColor.calendarYellow.color
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(red: 1, green: 0.83, blue: 0.44, alpha: 1).cgColor
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 3
        
        setupConstraints()
        
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        leftView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftView.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
