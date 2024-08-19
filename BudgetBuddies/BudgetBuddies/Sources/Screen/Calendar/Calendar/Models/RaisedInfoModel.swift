//
//  RaisedInfoModel.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/13/24.
//

import Foundation

struct RaisedInfoModel {
  let title: String?
  let startDate: String?
  let endDate: String?
  let infoType: InfoType  // 할인, 지원정보 여부는 직접 값을 넣어서 사용
}

extension RaisedInfoModel {
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
  // 일정이 여러 줄에 걸쳐 있으면, 각 줄에 맞게 잘라서 같은 title의 다른 RaisedInfoModel을 반환하는 함수
  func splitIntoRows() -> [RaisedInfoModel] {
    var sortedModels: [RaisedInfoModel] = []

    guard let startDateString = startDate,
      let endDateString = endDate,
      let startDate = date(from: startDateString),
      let endDate = date(from: endDateString),
      let startPosition = positionOfDate(for: startDate),
      let endPosition = positionOfDate(for: endDate)
    else {
      return sortedModels
    }

    let calendar = Calendar.current
    let numberOfRows = endPosition.row - startPosition.row + 1

    for row in 0..<numberOfRows {
      let startDateForRow: Date
      let endDateForRow: Date

      if row == 0 {
        // 첫 번째 행의 경우, 시작 날짜는 그대로, 끝 날짜는 그 주의 마지막 날짜로 설정
        startDateForRow = startDate
        let daysUntilEndOfWeek = 6 - startPosition.column
        endDateForRow = calendar.date(
          byAdding: .day, value: daysUntilEndOfWeek, to: startDateForRow)!
      } else {
        // 이후 행의 경우, 시작 날짜는 그 주의 첫 번째 날, 끝 날짜는 그 주의 마지막 날 또는 실제 종료 날짜로 설정
        let daysToAdd = row * 7 - startPosition.column
        startDateForRow = calendar.date(byAdding: .day, value: daysToAdd, to: startDate)!
        if row == numberOfRows - 1 {
          endDateForRow = endDate
        } else {
          endDateForRow = calendar.date(byAdding: .day, value: 6, to: startDateForRow)!
        }
      }

      // 새로운 RaisedInfoModel 생성
      let newModel = RaisedInfoModel(
        title: self.title,
        startDate: formattedDate(date: startDateForRow),
        endDate: formattedDate(date: endDateForRow),
        infoType: self.infoType
      )
      sortedModels.append(newModel)
    }

    return sortedModels
  }

  func sortRaisedInfoModelsByDate(_ models: [RaisedInfoModel]) -> [RaisedInfoModel] {
    return models.sorted { first, second in
      guard let firstDateString = first.startDate,
        let secondDateString = second.startDate,
        let firstDate = date(from: firstDateString),
        let secondDate = date(from: secondDateString)
      else {
        return false
      }
      return firstDate < secondDate
    }
  }

  // Date를 "yyyy-MM-dd" 포맷의 문자열로 변환하는 함수
  private func formattedDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
  }

}
