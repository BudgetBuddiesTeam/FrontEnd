//
//  ConsumptionAnalysisResponseDto.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/15/24.
//

import Foundation

struct ConsumptionAnalysisResponseDto: Codable {
  let goalCategory: String
  let currentWeekConsumptionAmount: Int
}
