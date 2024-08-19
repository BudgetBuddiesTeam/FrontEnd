//
//  CompactExpenseResponseDto.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/19/24.
//

import Foundation

struct CompactExpenseResponseDto: Codable {
    let expenseID: Int
    let description: String
    let amount, categoryID: Int

    enum CodingKeys: String, CodingKey {
        case expenseID = "expenseId"
        case description, amount
        case categoryID = "categoryId"
    }
}
