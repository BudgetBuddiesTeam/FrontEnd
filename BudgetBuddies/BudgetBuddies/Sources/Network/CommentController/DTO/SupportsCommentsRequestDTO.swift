//
//  SupportsCommentsRequestDTO.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/17/24.
//

import Foundation

// MARK: - SupportsCommentsRequest
struct SupportsCommentsRequestDTO: Codable {
    let content: String
    let supportInfoID: Int

    enum CodingKeys: String, CodingKey {
        case content
        case supportInfoID = "supportInfoId"
    }
}

