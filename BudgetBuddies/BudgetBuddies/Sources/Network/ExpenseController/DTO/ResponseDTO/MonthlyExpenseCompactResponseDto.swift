//
//  MonthlyExpenseCompactResponseDto.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/19/24.
//

import Foundation

struct MonthlyExpenseCompactResponseDto: Codable {
    let expenseMonth: String
    let totalConsumptionAmount: Int
    let expenses: [String: [CompactExpenseResponseDto]]
}
