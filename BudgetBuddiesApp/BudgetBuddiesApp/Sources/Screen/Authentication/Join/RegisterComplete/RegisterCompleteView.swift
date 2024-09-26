//
//  RegisterCompleteView.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/26/24.
//

import UIKit
import SnapKit

class RegisterCompleteView: UIView {
    // MARK: - UI Components
    // 환영합니다! 주머니 채우러 가볼까요 ?
    let bigTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "환영합니다!\n주머니 채우러 가볼까요?"
        lb.textColor = BudgetBuddiesAppAsset.AppColor.textBlack.color
        lb.font = BudgetBuddiesAppFontFamily.Pretendard.semiBold.font(size: 24)
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.setCharacterAndLineSpacing(characterSpacing: -0.6, lineSpacing: 0.0, lineHeightMultiple: 1.26)
        return lb
    }()
    
    let subTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "빈주머니즈와 함께 현명한 소비를 즐겨봐요"
        lb.textColor = BudgetBuddiesAppAsset.AppColor.subGray.color
        lb.font = BudgetBuddiesAppFontFamily.Pretendard.regular.font(size: 14)
        lb.textAlignment = .center
        lb.setCharacterSpacing(-0.35)
        return lb
    }()
    
    lazy var titleStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [bigTitleLabel, subTitleLabel])
        sv.axis = .vertical
        sv.spacing = 9
        sv.alignment = .center
        sv.distribution = .fill
        return sv
    }()
    
    let completeImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "completeImage")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let emptySpaceView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var allStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [titleStackView, completeImageView, emptySpaceView])
        sv.axis = .vertical
        sv.spacing = 40
        sv.alignment = .center
        sv.distribution = .fill
        return sv
    }()
    
    // 시작하기 버튼
    lazy var startButton = YellowRectangleButton(.start, isButtonEnabled: true)

    // MARK: - init
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
        
        self.addSubviews(allStackView, startButton)
        
        setupConstraints()
    }
    
    // MARK: - Set up Constraints
    private func setupConstraints() {
        let bigTitleHeight = 72 + 1 // 여유값 + 1
        let subTitleHeight = 21
        let titleStackHeight = bigTitleHeight + subTitleHeight + 9
        
        bigTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(bigTitleHeight)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(subTitleHeight)
        }
        
        titleStackView.snp.makeConstraints { make in
            make.height.equalTo(titleStackHeight)
        }
        
        completeImageView.snp.makeConstraints { make in
            make.height.equalTo(240)
//            make.width.equalTo(210)
        }
        
        emptySpaceView.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        allStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
//            make.leading.trailing.equalToSuperview()
        }
        
        // 시작버튼
        startButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(54)
        }
    }
}
