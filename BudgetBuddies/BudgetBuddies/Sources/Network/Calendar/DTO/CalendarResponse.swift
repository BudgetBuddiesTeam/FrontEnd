//
//  CalendarResponse.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/10/24.
//

import Foundation

// MARK: - CalendarResponse
struct CalendarResponse: Codable {
  let calendarMonthInfoDto: MonthInfoDto
  let recommendMonthInfoDto: MonthInfoDto
}

// MARK: - MonthInfoDto
struct MonthInfoDto: Codable {
  let discountInfoDtoList: [InfoDtoList]
  let supportInfoDtoList: [InfoDtoList]
}

// MARK: - TInfoDtoList
struct InfoDtoList: Codable {
  let id: Int
  let title, startDate, endDate: String
  let likeCount: Int
  let discountRate: Int?
  let siteURL: String

  enum CodingKeys: String, CodingKey {
    case id, title, startDate, endDate, likeCount, discountRate
    case siteURL = "siteUrl"
  }

  // 셀에 보여줄 날짜로 가공
  var dateRangeString: String? {
    // DateFormatter를 설정하여 날짜 형식을 'MM.dd'로 변환
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM.dd"

    // DateFormatter를 설정하여 입력 날짜 형식을 'yyyy-MM-dd'로 설정
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"

    // 날짜 문자열을 Date 객체로 변환
    guard let startDate = inputFormatter.date(from: startDate),
      let endDate = inputFormatter.date(from: endDate)
    else {
      return nil
    }

    // 변환된 날짜를 'MM.dd' 형식으로 변환하고 문자열로 반환
    return "\(dateFormatter.string(from: startDate)) ~ \(dateFormatter.string(from: endDate))"
  }
}
