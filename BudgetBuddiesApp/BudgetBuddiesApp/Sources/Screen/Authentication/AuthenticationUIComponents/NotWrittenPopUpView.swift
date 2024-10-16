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
    
    lazy var alertLabel: UILabel = {
        let lb = UILabel()
        lb.text = " "
        lb.textColor = BudgetBuddiesAppAsset.AppColor.white.color
        lb.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
        lb.setCharacterSpacing(-0.4)
        lb.textAlignment = .center
        return lb
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    // 알림창 뜨게 하는 애니메이션 함수
    func popUp(with information: NotWrittenInformation) {
        alertLabel.text = information.rawValue
        
        // 나타나는 애니메이션
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        } completion: { _ in
            // 나타나는 애니메이션 뒤에 없어지는 애니메이션
            UIView.animate(withDuration: 0.6, delay: 1.5) {
                self.alpha = 0
            }
        }

    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.alpha = 0
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
