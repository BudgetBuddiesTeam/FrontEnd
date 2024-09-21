//
//  BasicInformationView.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/19/24.
//

import UIKit
import SnapKit

class BasicInformationView: UIView {
    // MARK: - UI Components
    let contentView = UIView()
    let scrollView = UIScrollView()
    
    let stepDot = StepDotView(steps: .secondStep)
    
    // 기본정보를 입력해주세요
    let bigTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "기본정보를 입력해주세요"
        lb.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
        lb.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 24)
        lb.numberOfLines = 0
        lb.textAlignment = .left
        lb.setCharacterSpacing(-0.6)
        return lb
    }()
    
    let subTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "정보를 바탕으로 레포트를 제공해요"
        lb.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
        lb.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 14)
        lb.setCharacterSpacing(-0.35)
        return lb
    }()
    
    lazy var titleStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [bigTitleLabel, subTitleLabel])
        sv.axis = .vertical
        sv.spacing = 9
        sv.alignment = .leading
        sv.distribution = .fill
        return sv
    }()
    
    // 이름(닉네임)
    let nameLabel = basicLabel("이름 (닉네임)")
    
    lazy var nameTextField = ClearBackgroundTextFieldView(textFieldType: .Name)
    
    lazy var nameStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        sv.axis = .vertical
        sv.spacing = 8
        sv.alignment = .leading
        sv.distribution = .fill
        return sv
    }()
    
    // 성별
    let genderLabel = basicLabel("성별")
    
    // 연령
    
    
    // 계속하기 버튼
    lazy var keepGoingButton: YellowRectangleButton = {
        let btn = YellowRectangleButton(.conti, isButtonEnabled: true)
        return btn
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
        
        self.addSubviews(scrollView, keepGoingButton)
        scrollView.addSubviews(contentView)
        
        contentView.addSubviews(stepDot, titleStackView, nameStackView)
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(keepGoingButton.snp.top).offset(-16)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.bottom.equalTo(titleStackView.snp.bottom)
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(1000)
        }
        
        stepDot.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(32)
        }
        
        bigTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(36)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(21)
        }
        
        titleStackView.snp.makeConstraints { make in
            make.height.equalTo(36 + 21 + 9)
            make.top.equalTo(stepDot.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        keepGoingButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(54)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.leading.trailing.equalToSuperview()
        }
        
        nameStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(self.titleStackView.snp.bottom).offset(72)
        }
    }
}
