//
//  DiscountResponseDTO.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/22/24.
//

import Foundation

// MARK: - DiscountResponseDTO
struct DiscountResponseDTO: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: DiscountResult
}

// MARK: - Result
struct DiscountResult: Codable {
    let id: Int
    let title, startDate, endDate: String
    let anonymousNumber, discountRate, likeCount: Int
    let siteURL, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case id, title, startDate, endDate, anonymousNumber, discountRate, likeCount
        case siteURL = "siteUrl"
        case thumbnailURL = "thumbnailUrl"
    }
}

