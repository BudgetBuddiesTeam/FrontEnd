//
//  InfoColorView.swift
//  BudgetBuddiesLocal
//
//  Created by 김승원 on 7/15/24.
//

import UIKit

class CustomInfoColorView: UIView {
    
    enum InfoType {
        case discount
        case support
    }
    
    // MARK: - Properties
    let colorView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    let infoLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Pretendard-Regular", size: 12)
        let attributedString = NSMutableAttributedString(string: lb.text ?? "")
        let letterSpacing: CGFloat = -0.3
        attributedString.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))
        lb.textColor = #colorLiteral(red: 0.5098040104, green: 0.5098040104, blue: 0.5098040104, alpha: 1)
        return lb
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [colorView, infoLabel])
        sv.axis = .horizontal
        sv.spacing = 7
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    // MARK: - override init
    init(infoType: InfoType, infoText: String) {
        super.init(frame: .zero)
        
        self.infoLabel.text = infoText
        
        switch infoType {
        case .discount:
            self.colorView.backgroundColor = #colorLiteral(red: 1, green: 0.7009802461, blue: 0.0008154966054, alpha: 1)
        case .support:
            self.colorView.backgroundColor = #colorLiteral(red: 0, green: 0.6331792474, blue: 0.947116673, alpha: 1)
        }
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.backgroundColor = .clear
        self.addSubview(stackView)
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        colorView.snp.makeConstraints { make in
            make.height.width.equalTo(15)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
