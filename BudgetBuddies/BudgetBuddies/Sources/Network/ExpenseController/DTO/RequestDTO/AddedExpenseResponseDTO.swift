//
//  AddedExpenseResponseDTO.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/16/24.
//

import Foundation

struct AddedExpenseResponseDTO: Codable {
  let expenseId: Int
  let userId: Int
  let categoryId: Int
  let categoryName: String
  let amount: Int
  let description: String
  let expenseDate: String
}
