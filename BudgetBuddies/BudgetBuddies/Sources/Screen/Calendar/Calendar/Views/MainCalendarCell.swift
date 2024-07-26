//
//  MainCalendarCell.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/25/24.
//

import UIKit

class MainCalendarCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "MainCalendarCell"

    // MARK: - UI Components
    // 뒷 배경
    var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 5 //반경
        view.layer.shadowOffset = CGSize(width: 0, height: 0) //위치조정
        view.layer.masksToBounds = false //
        return view
    }()
    
    // 할인정보, 지원정보
    var discountInfo = CustomInfoColor(infoType: .discount)
    var supportInfo = CustomInfoColor(infoType: .support)
    
    lazy var infoStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [discountInfo, supportInfo])
        sv.axis = .horizontal
        sv.spacing = 11
        sv.alignment = .center
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
        self.backgroundColor = .clear
        self.addSubviews(backView)
        self.contentView.addSubviews(infoStackView)
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        // 캘린더 백뷰
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(510)
        }
        
        // 할인정보, 지원정보
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.bottom).offset(7)
            make.leading.equalTo(backView.snp.leading).inset(11)
        }
        
    }
}
