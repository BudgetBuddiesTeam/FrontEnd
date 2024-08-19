//
//  UserConsumptionGoalResponse.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/16/24.
//

import Foundation

struct UserConsumptionGoalResponse: Codable {
  let cateogoryId: Int
  let goalMonth: String
  let consumeAmount: Int
  let goalAmount: Int
}
