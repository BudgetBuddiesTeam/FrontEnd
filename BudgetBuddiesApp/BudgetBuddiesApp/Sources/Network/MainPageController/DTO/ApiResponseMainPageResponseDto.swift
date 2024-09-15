//
//  ApiResponseMainPageResponseDto.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/15/24.
//

import Foundation

struct ApiResponseMainPageResponseDto: Codable {
  let isSuccess: Bool
  let code: String
  let message: String
  let result: MainPageResponseDto
}
