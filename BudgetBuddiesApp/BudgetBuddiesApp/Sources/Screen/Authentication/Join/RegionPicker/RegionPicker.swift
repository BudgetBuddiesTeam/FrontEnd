//
//  RegionPicker.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/24/24.
//

import UIKit
import SnapKit

class RegionPicker: UIView {
    // MARK: - UI Components
    // topRectView
    var topRectView: UIView = {
        let view = UIView()
        view.backgroundColor = BudgetBuddiesAppAsset.AppColor.circleStroke.color
        return view
    }()
    
    // 거주지역 선택 label
    let selectRegionLabel: UILabel = {
        let lb = UILabel()
        lb.text = "거주지역 선택"
        lb.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 16)
        lb.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
        lb.setCharacterSpacing(-0.4)
        lb.textAlignment = .left
        return lb
    }()
    
    // 거주지역 담는 뷰
    let regionView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.886, green: 0.886, blue: 0.886, alpha: 1).cgColor

        return view
    }()
    
    let tempView = UIView()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 0
        sv.alignment = .fill
        sv.distribution = .fill
        sv.layer.borderWidth = 1
        sv.layer.borderColor = UIColor(red: 0.886, green: 0.886, blue: 0.886, alpha: 1).cgColor
        sv.layer.masksToBounds = true
        sv.layer.cornerRadius = 12
        return sv
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 모서리 둥글게
        self.topRectView.layer.masksToBounds = true
        self.topRectView.layer.cornerRadius = topRectView.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        // backView (자기 자신)
        self.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 24
        self.layer.maskedCorners = CACornerMask(
          arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        self.addSubviews(topRectView, stackView)
        stackView.addArrangedSubview(regionView)
        stackView.addArrangedSubview(tempView)
        self.regionView.addSubviews(selectRegionLabel)
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        topRectView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(4)
        }
        
        selectRegionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(85)
        }
        
        regionView.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.leading.trailing.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(topRectView.snp.bottom).offset(52)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}
