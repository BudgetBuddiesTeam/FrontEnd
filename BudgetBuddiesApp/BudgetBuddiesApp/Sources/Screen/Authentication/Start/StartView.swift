//
//  StartView.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/16/24.
//

import UIKit
import SnapKit

class StartView: UIView {
    // MARK: - UI Components
    // 시작하기 버튼
    let nextButton = YellowRectangleButton(.start, isButtonEnabled: true)
    
    // 이미 계정이 있나요? 로그인
    let alreadyHaveLabel = SubLabel(grayText: "이미 계정이 있나요?", yellowText: "로그인", isLined: true)

    
    // 로고 이미지
    let logoImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "readyInfoImage")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // 빈주머니즈
    let title: UILabel = {
        let lb = UILabel()
        lb.text = "빈주머니즈"
        lb.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 24)
        lb.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
        lb.setCharacterSpacing(-0.6)
        return lb
    }()
    
    // 빈 주머니로도 경험 ...
    let subTitle: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.text = "빈 주머니로도 경험을 사고픈 청춘들의\n폼 나게 허리띠 졸라매는 법"
        lb.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 14)
        lb.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
        lb.textAlignment = .center
        lb.setCharacterSpacing(-0.35)
        lb.setLineSpacing(lineSpacing: 0.0, lineHeightMultiple: 1.26)
        return lb
    }()
    
    // 라벨 스택뷰
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [logoImage, title, subTitle])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .center
        sv.spacing = 4

        return sv
    }()
    
    /*
     임시 버튼
     */
    let tempButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("메인화면으로 가기", for: .normal)
        btn.setTitleColor(.lightGray, for: .normal)
        return btn
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setTempButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
     임시 버튼 함수임 나중에 지우기
     */
    private func setTempButton() {
        self.addSubview(tempButton)
        
        tempButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Set up UI
    private func setupUI() {
        self.backgroundColor = BudgetBuddiesAppAsset.AppColor.white.color
        
        self.addSubviews(alreadyHaveLabel, nextButton, stackView)
        setupConstraints()
    }

    // MARK: - Set up Constraints
    private func setupConstraints() {
        alreadyHaveLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(24)
            make.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(54)
            make.bottom.equalTo(self.alreadyHaveLabel.snp.top).offset(-13)
        }
        
        logoImage.snp.makeConstraints { make in
            make.height.width.equalTo(116)
        }
        
        title.snp.makeConstraints { make in
            make.height.equalTo(36)
        }
        
        subTitle.snp.makeConstraints { make in
            make.height.equalTo(43)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.leading.trailing.equalToSuperview()
        }
    }
}
