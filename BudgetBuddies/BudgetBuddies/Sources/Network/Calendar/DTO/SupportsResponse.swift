//
//  SupportsResponse.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/8/24.
//

import Foundation

// MARK: - SupportInfoResponse
struct SupportsResponse: Codable {
  let totalPages, totalElements, size: Int
  let content: [SupportContent]
  let number: Int
  let sort: SupportSort
  let pageable: SupportPageable
  let numberOfElements: Int
  let first, last, empty: Bool
}

// MARK: - Content
struct SupportContent: Codable {
  let id: Int
  let title, startDate, endDate: String
  let anonymousNumber, likeCount: Int
  let siteURL, thumbnailURL: String

  enum CodingKeys: String, CodingKey {
    case id, title, startDate, endDate, anonymousNumber, likeCount
    case siteURL = "siteUrl"
    case thumbnailURL = "thumbnailUrl"
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

// MARK: - Pageable
struct SupportPageable: Codable {
  let offset: Int
  let sort: SupportSort
  let unpaged, paged: Bool
  let pageNumber, pageSize: Int
}

// MARK: - Sort
struct SupportSort: Codable {
  let empty, unsorted, sorted: Bool
}
