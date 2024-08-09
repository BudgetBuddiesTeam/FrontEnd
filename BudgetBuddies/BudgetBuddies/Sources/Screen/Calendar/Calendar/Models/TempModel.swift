//
//  TempModel.swift
//  BudgetBuddies
//
//  Created by 김승원 on 7/29/24.
//

import UIKit

// 임시 모델을 계속 사용하다보니까 이 모델에 대한 의존성이 높아져서
// 추후에 api연결할 때 제대로 구현하겠습니다!
// 임시 모델
struct YearMonth {
  let year: Int?
  let month: Int?
  //    let infoModels: [InfoModel] = []
}

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

enum InfoType {
  case discount
  case support
}

// 이거는 할인, 지원 정보 모델
struct InfoModel {
  let title: String?
  let startDate: String?
  let endDate: String?
  let infoType: InfoType
}

extension InfoModel {
  // 날짜 문자열을 Date객체로 변환하는 함수
  private func date(from dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: dateString)
  }

  // 주어진 날짜의 월의 첫 번째 날의 요일을 반환하는 함수
  private func startOfMonth(for date: Date) -> Int? {
    let calendar = Calendar.current
    var components = calendar.dateComponents([.year, .month], from: date)
    components.day = 1

    guard let firstDayOfMonth = calendar.date(from: components) else { return nil }
    return calendar.component(.weekday, from: firstDayOfMonth)
  }

  // 주어진 날짜가 포함된 월의 총 일수를 반환하는 함수
  private func numberOfDaysInMonth(for date: Date) -> Int? {
    let calendar = Calendar.current
    guard let range = calendar.range(of: .day, in: .month, for: date) else { return nil }
    return range.count
  }

  // 주어진 날짜의 위치를 (행, 열) 형태로 반환하는 함수
  private func positionOfDate(for date: Date) -> (row: Int, column: Int)? {
    guard let startDay = startOfMonth(for: date),
      //      let numberOfDays = numberOfDaysInMonth(for: date)
      let _ = numberOfDaysInMonth(for: date)
    else {
      return nil
    }

    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    guard let day = components.day else { return nil }

    let startDayIndex = startDay - 1
    let dayIndex = startDayIndex + (day - 1)

    let row = dayIndex / 7
    let column = dayIndex % 7

    return (row, column)
  }

  // 기간의 시작하는 위치를 (row, column)형태로 반환하는 함수
  func startDatePosition() -> (row: Int, column: Int)? {
    guard let startDateString = startDate,
      let date = date(from: startDateString)
    else { return nil }
    return positionOfDate(for: date)
  }

  // 기간의 끝나는 위치를 (row, column)형태로 반환하는 함수
  func endDatePosition() -> (row: Int, column: Int)? {
    guard let endDateString = endDate,
      let date = date(from: endDateString)
    else { return nil }
    return positionOfDate(for: date)
  }

  // 일정이 캘린더에서 몇줄에 걸쳐있는지 반환하는 함수
  func numberOfRows() -> Int? {
    guard let startDateString = startDate,
      let endDateString = endDate,
      let startDate = date(from: startDateString),
      let endDate = date(from: endDateString)
    else { return nil }

    guard let startPosition = positionOfDate(for: startDate),
      let endPosition = positionOfDate(for: endDate)
    else { return nil }

    // 시작 날짜와 끝나는 날짜가 위치한 줄을 계산
    let numberOfRows = endPosition.row - startPosition.row + 1
    return numberOfRows
  }
}
