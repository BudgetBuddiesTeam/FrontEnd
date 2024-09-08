//
//  ResponseUserDto.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/16/24.
//

import Foundation

struct ResponseUserDto: Codable {
  let id: Int
  let phoneNumber, name, email: String
  let age: Int
  let gender, photoURL, consumptionPattern, lastLoginAt: String

  enum CodingKeys: String, CodingKey {
    case id, phoneNumber, name, email, age, gender
    case photoURL = "photoUrl"
    case consumptionPattern, lastLoginAt
  }
}
