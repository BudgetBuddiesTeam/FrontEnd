//
//  SupportResponseDto.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/11/24.
//

import Foundation

// MARK: - SupportResponseDto

struct SupportResponseDto: Codable {
  let id: Int
  let title: String
  let startDate: String
  let endDate: String
  let anonymousNumber: Int
  let likeCount: Int
  let siteUrl: String
  let thumbnailUrl: String
}
