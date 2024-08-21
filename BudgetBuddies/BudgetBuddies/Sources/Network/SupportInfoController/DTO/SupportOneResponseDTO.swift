//
//  SupportOneResponseDTO.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/22/24.
//

import Foundation

// MARK: - SupportResponseDTO
struct SupportOneResponseDTO: Codable {
  let isSuccess: Bool
  let code, message: String
  let result: SupportResult
}

// MARK: - Result
struct SupportResult: Codable {
  let id: Int
  let title, startDate, endDate: String
  let anonymousNumber, likeCount: Int
  let siteURL, thumbnailURL: String

  enum CodingKeys: String, CodingKey {
    case id, title, startDate, endDate, anonymousNumber, likeCount
    case siteURL = "siteUrl"
    case thumbnailURL = "thumbnailUrl"
  }
}
