//
//  DiscountResponse.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/8/24.
//

import Foundation

// MARK: - DiscountResponse
struct DiscountResponse: Codable {
    let totalPages, totalElements, size: Int
    let content: [DiscountContent]
    let number: Int
    let sort: DiscountSort
    let pageable: DiscountPageable
    let numberOfElements: Int
    let first, last, empty: Bool
}

// MARK: - Content
struct DiscountContent: Codable {
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

// MARK: - Pageable
struct DiscountPageable: Codable {
    let offset: Int
    let sort: DiscountSort
    let unpaged, paged: Bool
    let pageNumber, pageSize: Int
}

// MARK: - Sort
struct DiscountSort: Codable {
    let empty, unsorted, sorted: Bool
}

