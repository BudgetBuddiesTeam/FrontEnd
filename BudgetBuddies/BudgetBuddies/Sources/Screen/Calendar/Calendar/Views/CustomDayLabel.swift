//
//  CustomDayLabel.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/29/24.
//

import UIKit

class CustomDayLabel: UILabel {
    init(dayOfWeek: String) {
        super.init(frame: .zero)
        
        self.text = dayOfWeek
        self.font = BudgetBuddiesFontFamily.Pretendard.regular.font(size: 16)
        self.setCharacterSpacing(-0.4)
        self.textAlignment = .center
        self.textColor = BudgetBuddiesAsset.AppColor.subGray.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/*
private let sunLabel: UILabel = {
    let lb = UILabel()
    lb.font = UIFont(name: "Pretendard-Regular", size: 16)
    lb.textColor = #colorLiteral(red: 0.4627450705, green: 0.4627450705, blue: 0.4627450705, alpha: 1)
    lb.text = "일"
    lb.textAlignment = .center
    return lb
}()
*/
