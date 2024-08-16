//
//  AddedExpenseRequestDTO.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/14/24.
//

import Foundation

struct AddedExpenseRequestDTO: Codable {
  let userId: Int
  let categoryId: Int
  let amount: Int
  let description: String
  let expenseDate: String
}
