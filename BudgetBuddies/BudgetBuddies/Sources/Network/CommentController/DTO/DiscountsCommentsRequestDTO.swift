//
//  DiscountsCommentsRequestDTO.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/17/24.
//

import Foundation

// MARK: - DiscountsCommentsRequest
struct DiscountsCommentsRequestDTO: Codable {
  let content: String
  let discountInfoID: Int

  enum CodingKeys: String, CodingKey {
    case content
    case discountInfoID = "discountInfoId"
  }
}
