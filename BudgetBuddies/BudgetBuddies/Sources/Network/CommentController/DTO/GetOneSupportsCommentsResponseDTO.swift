//
//  GetOneSupportsCommentsResponseDTO.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/18/24.
//

import Foundation

// MARK: - SupportsCommentsGetOneResponseDTO
struct GetOneSupportsCommentsResponseDTO: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: GetOneSupportsCommentsResult
}

// MARK: - Result
struct GetOneSupportsCommentsResult: Codable {
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
