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
  let expenseList: [Expense]
}

// MARK: - Expense

struct Expense: Codable {
  let expenseID: Int
  let expenseDescription: String
  let amount: Int
  let categoryID: Int
  let expenseDate: String

  enum CodingKeys: String, CodingKey {
    case expenseID = "expenseId"
    case categoryID = "categoryId"
    case expenseDescription = "description"
    case amount, expenseDate
  }
}
