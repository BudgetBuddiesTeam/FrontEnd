//
//  ConsumeResponse.swift
//  BudgetBuddies
//
//  Created by 이승진 on 8/11/24.
//

import Foundation

// MARK: - GetConsumeGoalResponse
struct GetConsumeGoalResponse: Codable {
  let isSuccess: Bool?
  let code: String?
  let message: String?
  let result: ConsumptionGoalResult?

  // MARK: - Result
  struct ConsumptionGoalResult: Codable {
    let goalMonth: String?
    let totalGoalAmount: Int?
    let totalConsumptionAmount: Int?
    let totalRemainingBalance: Int?
    let consumptionGoalList: [ConsumptionGoalList]?
  }

  // MARK: - ConsumptionGoalList
  struct ConsumptionGoalList: Codable {
    let categoryName: String?
    let categoryId: Int?
    let goalAmount: Int?
    let consumeAmount: Int?
    let remainingBalance: Int?
  }
}

// MARK: - GetTopGoalResponse
struct GetTopGoalResponse: Codable {
  let isSuccess: Bool?
  let code: String?
  let message: String?
  let result: [GetTopGoalResult]?

  // MARK: - GetTopGoalResult
  struct GetTopGoalResult: Codable {
    let categoryName: String?
    let avgAmount: Int?
    let amountDifference: Int?
  }
}

// MARK: - GetTopGoalsResponse
struct GetTopGoalsResponse: Codable {
  let isSuccess: Bool?
  let code: String?
  let message: String?
  let result: [GetTopGoalsResult]?

  // MARK: - GetTopGoalsResult
  struct GetTopGoalsResult: Codable {
    let categoryName: String?
    let goalAmount: Int?
  }
}

// MARK: - GetTopConsumptionResponse
struct GetTopConsumptionResponse: Codable {
  let isSuccess: Bool?
  let code: String?
  let message: String?
  let result: [GetTopConsumptionResult]?

  // MARK: - GetTopConsumptionResult
  struct GetTopConsumptionResult: Codable {
    let categoryName: String?
    let avgAmount: Int?
    let amountDifference: Int?
  }
}

// MARK: - GetTopConsumptionsResponse
struct GetTopConsumptionsResponse: Codable {
  let isSuccess: Bool?
  let code: String?
  let message: String?
  let result: [GetTopConsumptionsResult]?

  struct GetTopConsumptionsResult: Codable {
    let categoryName: String?
    let consumptionCount: Int?
  }
}

// MARK: - GetTopUserResponse
struct GetTopUserResponse: Codable {
  let isSuccess: Bool?
  let code: String?
  let message: String?
  let result: GetTopUserResult?

  // MARK: - GetTopUserResult
  struct GetTopUserResult: Codable {
    let goalCategory: String?
    let currentWeekConsumptionAmount: Int?
  }
}

// MARK: - ConsumePeerInfoResponse
struct ConsumePeerInfoResponse: Codable {
  let isSuccess: Bool?
  let code: String?
  let message: String?
  let result: ConsumePeerInfoResult?

  // MARK: - ConsumePeerInfoResult
  struct ConsumePeerInfoResult: Codable {
    let peerAgeStart: Int?
    let peerAgeEnd: Int?
    let peerGender: String?
  }
}

extension GetConsumeGoalResponse {
  public static var stub1: GetConsumeGoalResponse = .init(
    isSuccess: true,
    code: "string",
    message: "string",
    result: .init(
      goalMonth: "2024-08-17",
      totalGoalAmount: 0,
      totalConsumptionAmount: 0,
      totalRemainingBalance: 0,
      consumptionGoalList: [
        .init(
          categoryName: "string",
          categoryId: 0,
          goalAmount: 0,
          consumeAmount: 0,
          remainingBalance: 0
        )
      ]
    )
  )
}

extension GetTopGoalResponse {
  public static var stub1: GetTopGoalResponse = .init(
    isSuccess: true,
    code: "200",
    message: "okay",
    result: [
      .init(
        categoryName: "식비",
        avgAmount: 50000,
        amountDifference: 0
      )
    ]
  )
}

extension GetTopGoalsResponse {
  public static var stud1: GetTopGoalsResponse = .init(
    isSuccess: true,
    code: "string",
    message: "string",
    result: [
      .init(
        categoryName: "string",
        goalAmount: 0
      )
    ]
  )
}

extension GetTopConsumptionResponse {
  public static var stud1: GetTopConsumptionResponse = .init(
    isSuccess: true,
    code: "200",
    message: "okay",
    result: [
      .init(
        categoryName: "식비",
        avgAmount: 0,
        amountDifference: 0
      )
    ]
  )
}

extension GetTopConsumptionsResponse {
  public static var stud1: GetTopConsumptionsResponse = .init(
    isSuccess: true,
    code: "200",
    message: "okay",
    result: [
      .init(
        categoryName: "식비",
        consumptionCount: 1
      )
    ]
  )
}

extension GetTopUserResponse {
  public static var stud1: GetTopUserResponse = .init(
    isSuccess: true,
    code: "200",
    message: "okay",
    result: .init(
      goalCategory: "기타",
      currentWeekConsumptionAmount: 0
    )
  )
}

extension ConsumePeerInfoResponse {
  public static var stud1: ConsumePeerInfoResponse = .init(
    isSuccess: true,
    code: "200",
    message: "okay`",
    result: .init(
      peerAgeStart: 23,
      peerAgeEnd: 25,
      peerGender: "MALE"
    )
  )

}
