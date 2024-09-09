//
//  ConsumpotionGoalResponseListDTO.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/11/24.
//

import Foundation

// MARK: - ConsumptionGoalResponseListDto

struct ConsumptionGoalResponseListDto: Codable {
  let goalMonth: String
  let totalGoalAmount: Int
  let totalConsumptionAmount: Int
  let consumptionGoalList: [ConsumptionGoalResponseDto]
}

// MARK: - ConsumptionGoalResponseDto

struct ConsumptionGoalResponseDto: Codable {
  let categoryName: String
  let categoryId: Int
  let goalAmount: Int
  let consumeAmount: Int
}
