//
//  CompactExpenseResponseDto.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/20/24.
//

import Foundation

struct CompactExpenseResponseDto: Codable {
  let expenseId: Int
  let description: String
  let amount: Int
  let categoryId: Int
}
