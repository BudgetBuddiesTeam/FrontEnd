//
//  ExpenseResponseDTO.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/16/24.
//

import Foundation

struct ExpenseResponseDTO: Codable {
  let expenseId: Int
  let userId: Int
  let categoryId: Int
  let categoryName: String
  let amount: Int
  let expenseDescription: String
  let expenseDate: String

  enum CodingKeys: String, CodingKey {
    case expenseId, userId, categoryId, categoryName, amount, expenseDate
    case expenseDescription = "description"
  }
}
