//
//  MonthlyExpenseResponseDTO.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/14/24.
//

import Foundation

// MARK: - MonthlyExpenseResponseDTO

struct MonthlyExpenseResponseDTO: Codable {
  let expenseMonth: String
  let currentPage: Int
  let hasNext: Bool
  let expenseList: [ExpenseList]
}

// MARK: - ExpenseList

struct ExpenseList: Codable {
  let expenseID: Int
  let description: String
  let amount: Int
  let expenseDate: String

  enum CodingKeys: String, CodingKey {
    case expenseID = "expenseId"
    case description, amount, expenseDate
  }
}
