//
//  String+.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/11/24.
//

import Foundation

extension String {
  /// 날짜 포맷을 변환해주는 함수입니다.
  ///
  /// - InputFormat에 "2024-08-08"과 같은 날짜 형식
  /// - OutputFormat에 "08.08"과 같은 날짜 형식
  ///
  /// - Parameters:
  ///   - inputFormat: 변환하고 싶은 날짜 포맷
  ///   - outputFormat: 변환되었으면 하는 날짜 포맷
  func formatDate(from inputFormat: String, to outputFormat: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = inputFormat

    guard let date = dateFormatter.date(from: self) else {
      return nil
    }

    dateFormatter.dateFormat = outputFormat
    return dateFormatter.string(from: date)
  }

  /// "yyyy-MM-dd" 형식의 날짜 문자열 포맷을 "MM.dd" 형식의 날짜 포맷으로 바꿔주는 함수
  func toMMddFormat() -> String? {
    return formatDate(from: "yyyy-MM-dd", to: "MM.dd")
  }
}
