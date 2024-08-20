//
//  MonthlyExpenseResponseDto.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/20/24.
//

import Foundation

struct MonthlyExpenseResponseDto: Codable {
  let expenseMonth: String
  let totalConsumptionAmount: Int
  let dailyExpenses: [DailyExpenseResponseDto]
}
