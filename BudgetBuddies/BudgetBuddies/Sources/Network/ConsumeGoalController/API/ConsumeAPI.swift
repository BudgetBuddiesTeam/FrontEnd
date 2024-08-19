//
//  ConsumeAPI.swift
//  BudgetBuddies
//
//  Created by 이승진 on 8/11/24.
//

import Foundation

public enum ConsumeAPI {
    case getConsumeGoal(Int) // 소비 목표 조회
    case postConsumeGoal(Int) // 이번달 소비 목표 수정
    case getTopGoal // 또래들이 가장 많이 계획한 카테고리 & 평균 금액 및 내 목표 금액 차이 조회
    case getTopGoals // 또래들이 가장 큰 계획을 세운 카테고리 Top4
    case getTopConsumption // 또래들이 가장 많이 소비한 카테고리 & 평균 금액 및 내 소비금액 차이 조회
    case getTopConsumptions // 또래들이 가장 많이 소비한 카테고리 Top3
    case getTopUser // 또래들이 가장 큰 목표를 세운 카테고리와 그 카테고리에서 이번주 사용한 금액 조회
    case getPeerInfo // 또래나이와 성별 조회
    
    public var apiDesc: String {
        switch self {
        case .getConsumeGoal(let userId):
            return "/consumption-goals/\(userId)"
        case .postConsumeGoal(let userId):
            return "/consumption-goals/\(userId)"
        case .getTopGoal:
            return "/consumption-goals/categories/top-goals"
        case .getTopGoals:
            return "/consumption-goals/categories/top-goals/top-4"
        case .getTopConsumption:
            return "/consumption-goals/categories/top-consumptions"
        case .getTopConsumptions:
            return "/consumption-goals/categories/top-consumptions/top-3"
        case .getTopUser:
            return "/consumption-goals/category/top-goals"
        case .getPeerInfo:
            return "/consumption-goals/peer-info"
        
        }
    }
}
