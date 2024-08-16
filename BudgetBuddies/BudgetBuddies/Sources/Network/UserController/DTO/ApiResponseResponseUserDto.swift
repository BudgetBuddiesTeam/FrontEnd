//
//  ApiResponseResponseUserDto.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/16/24.
//

import Foundation

struct ApiResponseResponseUserDto: Codable {
  let isSuccess: Bool
  let code, message: String
  let result: ResponseUserDto
}
