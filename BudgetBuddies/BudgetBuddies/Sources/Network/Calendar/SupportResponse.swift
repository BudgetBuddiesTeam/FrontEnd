//
//  SupportResponse.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/5/24.
//

import Foundation

// MARK: - Welcome
struct SupportResponse: Codable {
    let totalPages, totalElements, size: Int
    let content: [Content]
    let number: Int
    let sort: Sort
    let pageable: Pageable
    let numberOfElements: Int
    let first, last, empty: Bool
}

// MARK: - Content
struct Content: Codable {
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
struct Pageable: Codable {
    let offset: Int
    let sort: Sort
    let unpaged: Bool
    let pageNumber: Int
    let paged: Bool
    let pageSize: Int
}

// MARK: - Sort
struct Sort: Codable {
    let empty, unsorted, sorted: Bool
}
