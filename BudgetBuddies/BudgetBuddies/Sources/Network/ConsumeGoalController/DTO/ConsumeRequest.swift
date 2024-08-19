//
//  ConsumeRequest.swift
//  BudgetBuddies
//
//  Created by 이승진 on 8/11/24.
//

import Foundation

// MARK: - ConsumeRequest
struct ConsumeRequest: Codable {
  let consumptionGoalList: [ConsumptionGoalList]
}

// MARK: - ConsumptionGoalList
struct ConsumptionGoalList: Codable {
  let categoryId, goalAmount: Int
}
