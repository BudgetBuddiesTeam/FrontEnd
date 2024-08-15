//
//  MainPageResponseDto.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/11/24.
//

import Foundation

// MARK: - MainPageResponseDto

struct MainPageResponseDto: Codable {
  let consumptionAnalysisResponseDto: ConsumptionAnalysisResponseDto
  let consumptionGoalResponseListDto: ConsumptionGoalResponseListDto
  let discountResponseDtoList: [DiscountResponseDto]
  let supportResponseDtoList: [SupportResponseDto]
}
