//
//  DailyExpenseResponseDto.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/20/24.
//

import Foundation

struct DailyExpenseResponseDto: Codable {
  let daysOfMonth: Int
  let daysOfTheWeek: String
  let expenses: [CompactExpenseResponseDto]
}
