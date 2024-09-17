//
//  StepDotView.swift
//  BudgetBuddiesApp
//
//  Created by 김승원 on 9/17/24.
//

import UIKit
import SnapKit

class StepDotView: UIView {
    // MARK: - Properties
    public enum Steps {
        case firstStep
        case secondStep
        case thirdStep
    }
    
    var steps: Steps
    
    // MARK: - UI Components
    let yellowDot: UIView = {
        let view = UIView()
        view.backgroundColor = BudgetBuddiesAppAsset.AppColor.coreYellow.color
        return view
    }()
    
    let firstGrayDot: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1) // 에셋 등록 해야함
        return view
    }()
    
    let secondGrayDot: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1) // 에셋 등록 해야함
        return view
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 6
        sv.alignment = .leading
        sv.distribution = .fill
        return sv
    }()
    
    // MARK: - init
    init(steps: Steps) {
        self.steps = steps
        
        super.init(frame: .zero)
        
        setupDots(self.steps)
    }
    
    override func layoutSubviews() {
        yellowDot.layer.masksToBounds = true
        firstGrayDot.layer.masksToBounds = true
        secondGrayDot.layer.masksToBounds = true
        
        yellowDot.layer.cornerRadius = yellowDot.frame.height / 2
        firstGrayDot.layer.cornerRadius = firstGrayDot.frame.width / 2
        secondGrayDot.layer.cornerRadius = secondGrayDot.frame.width / 2
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up Dots
    private func setupDots(_ steps: Steps) {
        self.addSubviews(stackView)
        
        switch steps {
        case .firstStep:
            stackView.addArrangedSubview(yellowDot)
            stackView.addArrangedSubview(firstGrayDot)
            stackView.addArrangedSubview(secondGrayDot)
            
        case .secondStep:
            stackView.addArrangedSubview(firstGrayDot)
            stackView.addArrangedSubview(yellowDot)
            stackView.addArrangedSubview(secondGrayDot)
            
        case .thirdStep:
            stackView.addArrangedSubview(firstGrayDot)
            stackView.addArrangedSubview(secondGrayDot)
            stackView.addArrangedSubview(yellowDot)
        }
        
        setupDotsConstraints()
    }
    
    // MARK: - Set up Dots Constraints
    private func setupDotsConstraints() {
        yellowDot.snp.makeConstraints { make in
            make.width.equalTo(13)
            make.height.equalTo(8)
        }
        
        firstGrayDot.snp.makeConstraints { make in
            make.width.height.equalTo(8)
        }
        
        secondGrayDot.snp.makeConstraints { make in
            make.width.height.equalTo(8)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(8)
        }
    }
}
