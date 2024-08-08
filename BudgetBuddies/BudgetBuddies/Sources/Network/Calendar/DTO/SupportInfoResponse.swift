//
//  SupportInfoResponse.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/8/24.
//

import Foundation

// MARK: - SupportInfoResponse
struct SupportInfoResponse: Codable {
    let totalPages, totalElements, size: Int
    let content: [SupportInfoContent]
    let number: Int
    let sort: SupportInfoSort
    let pageable: SupportInfoPageable
    let numberOfElements: Int
    let first, last, empty: Bool
}

// MARK: - Content
struct SupportInfoContent: Codable {
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
struct SupportInfoPageable: Codable {
    let offset: Int
    let sort: SupportInfoSort
    let unpaged, paged: Bool
    let pageNumber, pageSize: Int
}

// MARK: - Sort
struct SupportInfoSort: Codable {
    let empty, unsorted, sorted: Bool
}

