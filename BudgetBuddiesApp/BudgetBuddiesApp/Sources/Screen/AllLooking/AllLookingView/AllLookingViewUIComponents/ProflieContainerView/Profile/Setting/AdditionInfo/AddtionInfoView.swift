//
//  AddtionInfoView.swift
//  BudgetBuddiesApp
//
//  Created by 이승진 on 12/5/24.
//

import UIKit
import SnapKit

class AddtionInfoView: UIView {
    // MARK: - Properties
    var mobileCarrierButtonArray: [ClearBackgroundRadioButton] = []
    var interestCategoryButtonArray: [ClearBackgroundCheckBoxButton] = []
    
    // MARK: - UI Components
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
    
    // 저장하기 버튼
    lazy var saveButton: YellowRectangleButton = {
        let btn = YellowRectangleButton(.save, isButtonEnabled: true)
        return btn
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
            self.saveButton.isButtonEnabled = true
        } else {
            self.saveButton.isButtonEnabled = false
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
    
    // MARK: - Scroll To Bottom
//    func scrollToBottom(animated: Bool) {
//        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
//        if bottomOffset.y > 0 {
//            scrollView.setContentOffset(bottomOffset, animated: animated)
//        }
//    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
        
        [regionStackView, mobileCarrierStackView, interestedCategoryStackView, saveButton].forEach {
            self.addSubview($0)
        }
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        
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
            make.top.equalToSuperview().offset(128)
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
        
        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(54)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}

