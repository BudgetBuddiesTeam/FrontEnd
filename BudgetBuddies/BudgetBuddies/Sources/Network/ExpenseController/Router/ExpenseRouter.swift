//
//  ExpenseRouter.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/13/24.
//

import Foundation
import Moya

/*
 해야 할 일
 - getMonthlyExpenses 엔드포인트를 사용할 때, Query Parameter가 필수인데, 사용방법을 모르겠음
 */

enum ExpenseRouter {
  /// "expenses/{userId}" : 월별 소비조회
  ///
  /// - Parameter userId: 유저아이디
  case getMonthlyExpenses(userId: Int, date: String)

  /// "expenses/{userId}"
  ///
  /// - Parameters:
  ///   - userId: 유저아이디
  ///   - updatedExpenseRequestDTO: expenseId: Int, categoryId: Int, expenseDate: String, amount: Int 값을 갖는 POST JSON BODY
  case postUpdatedSingleExpense(userId: Int, updatedExpenseRequestDTO: ExpenseUpdateRequestDTO)

  /// "/expenses/add"
  ///
  /// - Parameter addedExpenseRequestDTO:
  /// userId: Int,
  /// categoryId: Int,
  /// amount: Int,
  /// description: String,
  /// expenseDate: String
  /// 값을 갖는 POST JSON BODY
  case postAddedExpense(userId: Int, addedExpenseRequestDTO: NewExpenseRequestDTO)

  /// "/expenses/{userId}/{expeseId}"
  ///
  /// - Parameters:
  ///   - userId: 유저아이디
  ///   - expenseId: 소비아이디
  case getSingleExpense(userId: Int, expenseId: Int)

  /// "/expenses/delete/{expenseId}"
  ///
  /// - Parameter expenseId: 소비아이디
  case deleteSingleExpense(expenseId: Int)
}

extension ExpenseRouter: TargetType {
  var baseURL: URL {
    URL(string: ServerInfo.baseURLString)!
  }

  var path: String {
    switch self {
    case .getMonthlyExpenses(let userId, _):
      return "/expenses/\(userId)"
    case .postUpdatedSingleExpense(let userId, _):
      return "/expenses/\(userId)"
    case .postAddedExpense(let userId, _):
      return "/expenses/add/\(userId)"
    case .getSingleExpense(let userId, let expenseId):
      return "/expenses/\(userId)/\(expenseId)"
    case .deleteSingleExpense(let expenseId):
      return "/expenses/delete/\(expenseId)"
    }
  }

  var method: Moya.Method {
    switch self {
    case .getMonthlyExpenses, .getSingleExpense:
      return .get
    case .postAddedExpense, .postUpdatedSingleExpense:
      return .post
    case .deleteSingleExpense:
      return .delete
    }
  }

  var task: Moya.Task {
    switch self {
    case .getMonthlyExpenses(_, let date):
      return .requestParameters(parameters: ["date": date], encoding: URLEncoding.queryString)
    case .getSingleExpense:
      return .requestPlain
    case .postUpdatedSingleExpense(_, let updatedExpenseRequestDTO):
      return .requestJSONEncodable(updatedExpenseRequestDTO)
    case .postAddedExpense(_, let addedExpenseRequestDTO):
      return .requestJSONEncodable(addedExpenseRequestDTO)
    case .deleteSingleExpense:
      return .requestPlain
    }
  }

  var headers: [String: String]? {
    return ["Content-type": "application/json"]
  }
}
