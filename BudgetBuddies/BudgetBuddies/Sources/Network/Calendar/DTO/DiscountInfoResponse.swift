//
//  DiscountInfoResponse.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/8/24.
//

import Foundation

// MARK: - DiscountInfoResponse
struct DiscountInfoResponse: Codable {
    let totalPages, totalElements, size: Int
    let content: [DiscountInfoContent]
    let number: Int
    let sort: DiscountInfoSort
    let pageable: DiscountInfoPageable
    let numberOfElements: Int
    let first, last, empty: Bool
}

// MARK: - Content
struct DiscountInfoContent: Codable {
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
struct DiscountInfoPageable: Codable {
    let offset: Int
    let sort: DiscountInfoSort
    let unpaged, paged: Bool
    let pageNumber, pageSize: Int
}

// MARK: - Sort
struct DiscountInfoSort: Codable {
    let empty, unsorted, sorted: Bool
}

