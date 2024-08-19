//
//  SupportsCommentsResponseDTO.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/17/24.
//

import Foundation

// MARK: - SupportsCommentsResponse
struct SupportsCommentsResponseDTO: Codable {
  let isSuccess: Bool
  let code, message: String
  let result: SupportsCommentsResult
}

// MARK: - Result
struct SupportsCommentsResult: Codable {
  let totalPages, totalElements, size: Int
  let content: [SupportsCommentsContent]
  let number: Int
  let sort: Sort
  let pageable: Pageable
  let numberOfElements: Int
  let first, last, empty: Bool
}

// MARK: - Content
struct SupportsCommentsContent: Codable {
  let commentID, userID, supportInfoID: Int
  let content: String
  let anonymousNumber: Int
  let createdAt: String

  enum CodingKeys: String, CodingKey {
    case commentID = "commentId"
    case userID = "userId"
    case supportInfoID = "supportInfoId"
    case content, anonymousNumber, createdAt
  }
}

// 공통으로 사용하는 페이징 정보 밖으로 따로 빼야할 듯 ⭐️
// MARK: - Pageable
struct Pageable: Codable {
  let offset: Int
  let sort: Sort
  let unpaged, paged: Bool
  let pageNumber, pageSize: Int
}

// MARK: - Sort
struct Sort: Codable {
  let empty, unsorted, sorted: Bool
}
