//
//  RegisterUserDTO.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/16/24.
//

import Foundation

struct RegisterUserDTO: Codable {
  let phoneNumber: String
  let name: String
  let age: Int
  let gender: String
  let email: String
  let photoURL: String
  let consumptionPattern: String

  enum CodingKeys: String, CodingKey {
    case phoneNumber, name, age, gender, email, consumptionPattern
    case photoURL = "photoUrl"
  }
}
