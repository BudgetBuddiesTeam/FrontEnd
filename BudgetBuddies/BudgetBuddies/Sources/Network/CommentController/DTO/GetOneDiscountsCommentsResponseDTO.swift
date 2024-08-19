//
//  GetOneDiscountsCommentsResponseDTO.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/18/24.
//

import Foundation

// MARK: - GetOneDiscountsCommentsResponseDTO
struct GetOneDiscountsCommentsResponseDTO: Codable {
  let isSuccess: Bool
  let code, message: String
  let result: GetOneDiscountsCommentsResult
}

// MARK: - Result
struct GetOneDiscountsCommentsResult: Codable {
  let commentID, userID, discountInfoID: Int
  let content: String
  let anonymousNumber: Int
  let createdAt: String

  enum CodingKeys: String, CodingKey {
    case commentID = "commentId"
    case userID = "userId"
    case discountInfoID = "discountInfoId"
    case content, anonymousNumber, createdAt
  }
}
