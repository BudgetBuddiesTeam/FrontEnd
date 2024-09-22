//
//  NotWrittenPopUpView.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/22/24.
//

import UIKit
import SnapKit

class NotWrittenPopUpView: UIView {
    // MARK: - Properties
    enum NotWrittenInformation: String {
        case name = "이름을 입력해주세요!"
        case gender = "성별을 선택해주세요!"
        case age = "연령을 선택해주세요!"
    }
    
    let notWrittenInformation: NotWrittenInformation
    
    lazy var alertLabel: UILabel = {
        let lb = UILabel()
        lb.text = self.notWrittenInformation.rawValue
        lb.textColor = BudgetBuddiesAppAsset.AppColor.white.color
        lb.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
        lb.setCharacterSpacing(-0.4)
        lb.textAlignment = .center
        return lb
    }()

    // MARK: - Init
    init(_ notWrittenInformation: NotWrittenInformation) {
        self.notWrittenInformation = notWrittenInformation
        
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.backgroundColor = .black.withAlphaComponent(0.75)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        self.addSubviews(alertLabel)
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        alertLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.trailing.equalToSuperview()
        }
    }
}
