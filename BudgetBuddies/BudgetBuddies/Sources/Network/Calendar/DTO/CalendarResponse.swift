//
//  CalendarResponse.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/10/24.
//

import Foundation

// MARK: - CalendarResponse
struct CalendarResponse: Codable {
    let calendarMonthInfoDto, recommendMonthInfoDto: MonthInfoDto
}

// MARK: - MonthInfoDto
struct MonthInfoDto: Codable {
    let discountInfoDtoList, supportInfoDtoList: [TInfoDtoList]
}

// MARK: - TInfoDtoList
struct TInfoDtoList: Codable {
    let id: Int
    let title, startDate, endDate: String
    let likeCount: Int
    let discountRate: Int?
    let siteURL: String

    enum CodingKeys: String, CodingKey {
        case id, title, startDate, endDate, likeCount, discountRate
        case siteURL = "siteUrl"
    }
}
