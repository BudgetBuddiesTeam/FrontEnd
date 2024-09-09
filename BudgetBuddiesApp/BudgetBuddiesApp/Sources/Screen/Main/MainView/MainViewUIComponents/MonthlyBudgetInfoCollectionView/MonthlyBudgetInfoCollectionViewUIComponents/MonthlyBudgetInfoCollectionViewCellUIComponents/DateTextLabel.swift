//
//  DateTextLabel.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/11/24.
//

import UIKit

class DateTextLabel: UILabel {
  /// 날짜 정보를 업데이트하는 메소드입니다.
  ///
  /// - Parameters:
  ///   - startDate: 시작날짜 문자열
  ///   - endDate: 종료날짜 문자열
  public func updateText(startDate: String, endDate: String) {
    let template = "{startDate} - {endDate}"
    let newText =
      template
      .replacingOccurrences(of: "{startDate}", with: startDate)
      .replacingOccurrences(of: "{endDate}", with: endDate)
    self.text = newText
  }
}
