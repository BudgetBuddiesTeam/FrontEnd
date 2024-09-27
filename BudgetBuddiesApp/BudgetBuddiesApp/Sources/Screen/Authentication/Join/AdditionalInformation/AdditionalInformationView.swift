//
//  AdditionalInformationView.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/23/24.
//

import UIKit
import SnapKit

class AdditionalInformationView: UIView {
    // MARK: - Properties
    var mobileCarrierButtonArray: [ClearBackgroundRadioButton] = []
    var interestCategoryButtonArray: [ClearBackgroundCheckBoxButton] = []
    
    // MARK: - UI Components
    let contentView = UIView()
    let scrollView = UIScrollView()
    
    let stepDot = StepDotView(steps: .thirdStep)
    
    // 추가정보를 입력하시면 맞춤정보를 받아보실 수 있어요
    let bigTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "추가정보를 입력하시면\n맞춤정보를 받아보실 수 있어요"
        lb.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
        lb.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 24)
        lb.numberOfLines = 0
        lb.textAlignment = .left
        lb.setCharacterAndLineSpacing(characterSpacing: -0.6, lineSpacing: 0.0, lineHeightMultiple: 1.26)
        return lb
    }()
    
    let subTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "나에게 꼭 맞는 할인/지원 정보를 받아보세요"
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
    
    // 건너뛰기, 선택 후 계속하기 버튼
    lazy var skipButton = ClearRectangleButton()
    
    lazy var continueButton: YellowRectangleButton = {
        let btn = YellowRectangleButton(.selectAndConti, isButtonEnabled: false)
        return btn
    }()
    
    lazy var buttonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [skipButton, continueButton])
        sv.axis = .horizontal
        sv.spacing = 12
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    // 거주지역
    let regionLabel = basicLabel("거주지역")
    
    let regionPickerView = DropDownMenuView()
    
    lazy var regionStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [regionLabel, regionPickerView])
        sv.axis = .vertical
        sv.spacing = 8
        sv.alignment = .leading
        sv.distribution = .fill
        return sv
    }()
    
    // 통신사
    let mobileCarrierLabel = basicLabel("통신사")
    
    let sktButton = ClearBackgroundRadioButton(buttonTitle: "SKT")
    let ktButton = ClearBackgroundRadioButton(buttonTitle: "KT")
    let lgUPlusButton = ClearBackgroundRadioButton(buttonTitle: "LG U+")
    let thriftyPhoneButton = ClearBackgroundRadioButton(buttonTitle: "알뜰폰")
    let elseButton = ClearBackgroundRadioButton(buttonTitle: "기타")
    private let emptySpaceView = UIView()
    
    lazy var firstMCStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [sktButton, ktButton])
        sv.axis = .horizontal
        sv.spacing = 13
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var secondMCStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [lgUPlusButton, thriftyPhoneButton])
        sv.axis = .horizontal
        sv.spacing = 13
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var thirdMCStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [elseButton, emptySpaceView])
        sv.axis = .horizontal
        sv.spacing = 13
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var mobileCarrierStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [mobileCarrierLabel, firstMCStackView, secondMCStackView, thirdMCStackView])
        sv.axis = .vertical
        sv.spacing = 8
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    // 관심 카테고리
    let interestCategorylabel = basicLabel("관심 카테고리")
    
    let foodExpensesButton = ClearBackgroundCheckBoxButton(interestCategory: .foodExpenses)
    let entertainmentExpensesButton = ClearBackgroundCheckBoxButton(interestCategory: .entertainmentExpenses)
    let cafeExpensesButton = ClearBackgroundCheckBoxButton(interestCategory: .cafeExpenses)
    let shoppingExpensesButton = ClearBackgroundCheckBoxButton(interestCategory: .shoppingExpenses)
    let fashionExpensesButton = ClearBackgroundCheckBoxButton(interestCategory: .fashionExpenses)
    let cultureExpensesButton = ClearBackgroundCheckBoxButton(interestCategory: .cultureExpenses)
    let transportationExpensesButton = ClearBackgroundCheckBoxButton(interestCategory: .transportationExpenses)
    let familyExpensesButton = ClearBackgroundCheckBoxButton(interestCategory: .familyEventExpenses)
    let regularPaymentExpensesButton = ClearBackgroundCheckBoxButton(interestCategory: .regularPaymentExpenses)
    
    lazy var firstICStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            foodExpensesButton,
            entertainmentExpensesButton,
            cafeExpensesButton,
            shoppingExpensesButton,
            fashionExpensesButton
        ])
        sv.axis = .horizontal
        sv.spacing = 8
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var secondICStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            cultureExpensesButton,
            transportationExpensesButton,
            familyExpensesButton,
            regularPaymentExpensesButton
        ])
        sv.axis = .horizontal
        sv.spacing = 8
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        return sv
    }()
    
    lazy var interestedCategoryStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [interestCategorylabel, firstICStackView, secondICStackView])
        sv.axis = .vertical
        sv.spacing = 12
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        addButtonsToArray()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Continue Button Toggle
    func continueButtonToggle(_ region: Bool, _ moblieCarrier: Bool, _ interestCategories: Bool) {
        if region || moblieCarrier || interestCategories {
            self.continueButton.isButtonEnabled = true
        } else {
            self.continueButton.isButtonEnabled = false
        }
    }
    
    // MARK: - Add Buttons to Array
    private func addButtonsToArray() {
        self.mobileCarrierButtonArray.append(contentsOf: [sktButton, ktButton, lgUPlusButton, thriftyPhoneButton, elseButton])
        
        self.interestCategoryButtonArray.append(contentsOf:[foodExpensesButton, entertainmentExpensesButton, cafeExpensesButton, shoppingExpensesButton, fashionExpensesButton, cultureExpensesButton, transportationExpensesButton, familyExpensesButton, regularPaymentExpensesButton])
    }
    
    // MARK: - Moblie Carrier RadioButton Toggle
    func moblieCarrierRadioButtonToggle(_ button: ClearBackgroundRadioButton) {
        
        mobileCarrierButtonArray.forEach { button in
            button.isButtonTapped = false
        }
        
        button.isButtonTapped = true
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
        
        self.addSubviews(scrollView, buttonStackView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(stepDot, titleStackView, regionStackView, mobileCarrierStackView, interestedCategoryStackView)
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        let bigTitleHeight = 72 + 1 // 여유값 + 1
        let subTitleHeight = 21
        let titleStackHeight = bigTitleHeight + subTitleHeight + 9
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(buttonStackView.snp.top).offset(-16)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.bottom.equalTo(interestedCategoryStackView.snp.bottom).offset(40)
            make.width.equalTo(scrollView.snp.width)
        }
        
        stepDot.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(32)
        }
        
        // 상단 타이틀
        bigTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(bigTitleHeight)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(subTitleHeight)
        }
        
        titleStackView.snp.makeConstraints { make in
            make.height.equalTo(titleStackHeight)
            make.top.equalTo(stepDot.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        // 건너뛰기, 선택 후 계속하기 버튼
        skipButton.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.width.equalTo(self.snp.width).multipliedBy(0.4)
        }
        
        continueButton.snp.makeConstraints { make in
            make.height.equalTo(54)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(54)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        // 거주지역
        regionLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        
        regionPickerView.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.leading.trailing.equalToSuperview()
        }
        
        regionStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(titleStackView.snp.bottom).offset(36)
        }
        
        // 통신사
        mobileCarrierLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        
        sktButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        ktButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        lgUPlusButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        thriftyPhoneButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        elseButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        emptySpaceView.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        firstMCStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        secondMCStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        thirdMCStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        mobileCarrierStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(regionStackView.snp.bottom).offset(40)
        }
        
        // 관심 카테고리
        interestCategorylabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        
        foodExpensesButton.snp.makeConstraints { make in
            make.height.equalTo(36)
        }
        
        entertainmentExpensesButton.snp.makeConstraints { make in
            make.height.equalTo(36)
        }
        
        cafeExpensesButton.snp.makeConstraints { make in
            make.height.equalTo(36)
        }
        
        shoppingExpensesButton.snp.makeConstraints { make in
            make.height.equalTo(36)
        }
        
        fashionExpensesButton.snp.makeConstraints { make in
            make.height.equalTo(36)
        }
        
        cultureExpensesButton.snp.makeConstraints { make in
            make.height.equalTo(36)
        }
        
        transportationExpensesButton.snp.makeConstraints { make in
            make.height.equalTo(36)
        }
        
        familyExpensesButton.snp.makeConstraints { make in
            make.height.equalTo(36)
        }
        
        regularPaymentExpensesButton.snp.makeConstraints { make in
            make.height.equalTo(36)
        }
        
        firstICStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        secondICStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        interestedCategoryStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(mobileCarrierStackView.snp.bottom).offset(40)
        }
    }
}
