//
//  MainPageResponseDTO.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/11/24.
//

import Foundation

// MARK: - MainPageResponseDTO

struct MainPageResponseDTO: Codable {
  let topGoalCategoryResponseDTO: TopGoalCategoryResponseDTO
  let consumptionGoalResponseListDto: ConsumptionGoalResponseListDto
  let discountResponseDtoList: [DiscountResponseDto]
  let supportResponseDtoList: [SupportResponseDto]
}
