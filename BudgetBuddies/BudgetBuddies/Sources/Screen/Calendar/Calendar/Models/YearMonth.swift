//
//  YearMonth.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/9/24.
//

import Foundation

struct YearMonth {
  let year: Int?
  let month: Int?
}

// MARK: - 6줄인지 판단하는 함수
extension YearMonth {
  func isSixWeeksLong() -> Bool {
    let calendar = Calendar.current

    // DateComponents를 사용하여 해당 월의 첫 날을 계산
    let components = DateComponents(year: year, month: month)
    guard let firstOfMonth = calendar.date(from: components) else {
      print("잘못된 날짜입니다.")
      return false
    }

    // 해당 월의 시작 요일과 총 일 수를 구합니다.
    let startDay = calendar.component(.weekday, from: firstOfMonth) - 1
    let numberOfDays = calendar.range(of: .day, in: .month, for: firstOfMonth)!.count

    // 주와 날 수를 계산합니다.
    let daysInWeek = 7
    let totalCells = 42  // 최대 6주
    var weeks: [[Int]] = Array(repeating: Array(repeating: 0, count: daysInWeek), count: 6)
    var numberOfWeeks = 0

    // 날짜를 기반으로 셀을 배치합니다.
    for i in 0..<totalCells {
      let day = i - startDay + 1
      if day > 0 && day <= numberOfDays {
        weeks[i / daysInWeek][i % daysInWeek] = day
      }
    }

    // 유효한 주 수를 계산합니다.
    for week in weeks {
      if week.contains(where: { $0 != 0 }) {
        numberOfWeeks += 1
      }
    }

    return numberOfWeeks > 5
  }
}
