//
//  DiscountsCommentsResponseDTO.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/17/24.
//

import Foundation

// MARK: - DiscountsCommentsResponse
struct DiscountsCommentsResponseDTO: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: DiscountsCommentsResult
}

// MARK: - Result
struct DiscountsCommentsResult: Codable {
    let totalPages, totalElements, size: Int
    let content: [DiscountsCommentsContent]
    let number: Int
    let sort: Sort
    let pageable: Pageable
    let numberOfElements: Int
    let first, last, empty: Bool
}

// MARK: - Content
struct DiscountsCommentsContent: Codable {
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

