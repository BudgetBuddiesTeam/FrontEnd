//
//  TopGoalCategoryResponseDTO.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/11/24.
//

import Foundation

// MARK: - TopGoalCategoryResponseDTO
struct TopGoalCategoryResponseDTO: Codable {
  let categoryName: String
  let goalAmount: Int
}
