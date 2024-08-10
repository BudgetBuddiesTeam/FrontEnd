//
//  CategoryResponse.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/5/24.
//

import Foundation

// MARK: - CategoryResponse
struct CategoryResponse: Codable {
  let id, userID: Int
  let name: String
  let isDefault: Bool

  enum CodingKeys: String, CodingKey {
    case id
    case userID = "userId"
    case name, isDefault
  }
}
