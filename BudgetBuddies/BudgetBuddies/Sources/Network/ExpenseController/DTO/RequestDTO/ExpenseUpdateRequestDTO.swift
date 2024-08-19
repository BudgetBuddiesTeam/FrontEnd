//
//  ExpenseUpdateRequestDTO.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/14/24.
//

import Foundation

struct ExpenseUpdateRequestDTO: Codable {
  let expenseId: Int
  let categoryId: Int
  let expenseDate: String
  let amount: Int
}
