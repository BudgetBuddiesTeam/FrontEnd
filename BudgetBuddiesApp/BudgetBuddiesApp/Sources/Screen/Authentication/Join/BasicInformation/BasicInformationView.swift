//
//  BasicInformationView.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/19/24.
//

import UIKit
import SnapKit

class BasicInformationView: UIView {
    // MARK: - Properties
    var ageButtonArray: [ClearBackgroundRadioButton] = []
    
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
    
    let maleButton = ClearBackgroundRadioButton(buttonTitle: "남성")
    let femaleButton = ClearBackgroundRadioButton(buttonTitle: "여성")
    
    lazy var genderButtonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [maleButton, femaleButton])
        sv.axis = .horizontal
        sv.spacing = 13
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var genderStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [genderLabel, genderButtonStackView])
        sv.axis = .vertical
        sv.spacing = 8
        sv.alignment = .leading
        sv.distribution = .fill
        return sv
    }()
    
    // 연령
    let ageLabel = basicLabel("연령")
    
    let leastTwentyButton = ClearBackgroundRadioButton(buttonTitle: "20세 미만")
    let twentyToTwentyTwoButton = ClearBackgroundRadioButton(buttonTitle: "20세-22세")
    let twentyThreeToTwentyFiveButton = ClearBackgroundRadioButton(buttonTitle: "23세-25세")
    let twentySixToTwentyEightButton = ClearBackgroundRadioButton(buttonTitle: "26세-28세")
    let overTwentyNineButton = ClearBackgroundRadioButton(buttonTitle: "29세 이상")
    let tempView = UIView()
    
    
    lazy var firstAgeButtonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [leastTwentyButton, twentyToTwentyTwoButton])
        sv.axis = .horizontal
        sv.spacing = 13
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var secondAgeButtonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [twentyThreeToTwentyFiveButton, twentySixToTwentyEightButton])
        sv.axis = .horizontal
        sv.spacing = 13
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var thirdAgeButtonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [overTwentyNineButton, tempView])
        sv.axis = .horizontal
        sv.spacing = 13
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var ageStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [ageLabel, firstAgeButtonStackView, secondAgeButtonStackView, thirdAgeButtonStackView])
        sv.axis = .vertical
        sv.spacing = 8
        sv.alignment = .leading
        sv.distribution = .fill
        return sv
    }()
    
    // 계속하기 버튼
    lazy var keepGoingButton: YellowRectangleButton = {
        let btn = YellowRectangleButton(.conti, isButtonEnabled: true)
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
    // MARK: - Add Buttons to Array
    private func addButtonsToArray() {
        self.ageButtonArray.append(leastTwentyButton)
        self.ageButtonArray.append(twentyToTwentyTwoButton)
        self.ageButtonArray.append(twentyThreeToTwentyFiveButton)
        self.ageButtonArray.append(twentySixToTwentyEightButton)
        self.ageButtonArray.append(overTwentyNineButton)
    }
    
    // MARK: - Gender RadioButton Toggle
    func genderRadioButtonToggle(_ button: ClearBackgroundRadioButton) {
        if button == maleButton {
            maleButton.isButtonTapped = true
            femaleButton.isButtonTapped = false
        } else {
            maleButton.isButtonTapped = false
            femaleButton.isButtonTapped = true
        }
    }
    
    // MARK: - Age RadioButton Toggle
    func ageRadioButtonToggle(_ button: ClearBackgroundRadioButton) {
        
        ageButtonArray.forEach { button in
            button.isButtonTapped = false
        }
        
        button.isButtonTapped = true
        
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
        
        self.addSubviews(scrollView, keepGoingButton)
        scrollView.addSubviews(contentView)
        
        contentView.addSubviews(stepDot, titleStackView, nameStackView, genderStackView, ageStackView)
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
            make.edges.equalToSuperview() // 가장자리를 먼저 고정시킨 뒤에
            make.bottom.equalTo(ageStackView.snp.bottom).offset(40) // bottom을 고정시키는 것이 스크롤뷰가 제대로 작동한다
            make.width.equalTo(scrollView.snp.width)
        }
        
        stepDot.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(32)
        }
        
        // 상단 타이틀
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
        
        // 계속하기 버튼
        keepGoingButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(54)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        // 이름 (닉네임)
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
        
        // 성별
        genderLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        
        maleButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        femaleButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        genderButtonStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        genderStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(self.nameStackView.snp.bottom).offset(40)
        }
        
        // 연령
        ageLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        
        leastTwentyButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        twentyToTwentyTwoButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        twentyThreeToTwentyFiveButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        twentySixToTwentyEightButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        overTwentyNineButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        tempView.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        firstAgeButtonStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        secondAgeButtonStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        thirdAgeButtonStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        ageStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(genderStackView.snp.bottom).offset(40)
        }
    }
}
