//
//  InfoColorView.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/12/24.
//

import UIKit
import SnapKit

class InfoColorView: UIView {
    // MARK: - UI Components
    var discountInfo = CustomInfoColor(infoType: .discount)
    var supportInfo = CustomInfoColor(infoType: .support)
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [discountInfo, supportInfo])
        sv.axis = .horizontal
        sv.spacing = 11
        sv.alignment = .center
        sv.distribution = .fill
        return sv
    }()
    
    // MARK: - init⭐️
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - set up UI
    private func setupUI() {
        self.addSubviews(stackView)
        
        setupConstraints()
    }
    
    // MARK: - set up Constraints
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(27)
            make.height.equalTo(15)
            make.centerY.equalToSuperview()
        }
    }
}
