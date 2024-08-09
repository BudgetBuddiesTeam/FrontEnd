//
//  SupportsResponse.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/8/24.
//

import Foundation

// MARK: - SupportInfoResponse
struct SupportsResponse: Codable {
    let totalPages, totalElements, size: Int
    let content: [SupportContent]
    let number: Int
    let sort: SupportSort
    let pageable: SupportPageable
    let numberOfElements: Int
    let first, last, empty: Bool
}

// MARK: - Content
struct SupportContent: Codable {
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

// MARK: - Pageable
struct SupportPageable: Codable {
    let offset: Int
    let sort: SupportSort
    let unpaged, paged: Bool
    let pageNumber, pageSize: Int
}

// MARK: - Sort
struct SupportSort: Codable {
    let empty, unsorted, sorted: Bool
}

