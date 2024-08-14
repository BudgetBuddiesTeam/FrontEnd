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
  case getMonthlyExpenses(userId: Int)
  case postUpdatedExpenses(userId: Int, updatedExpenseRequestDTO: UpdatedExpenseRequestDTO)
  case postAddedExpense(addedExpenseRequestDTO: AddedExpenseRequestDTO)
  case getSingleExpense(userId: Int, expenseId: Int)
}

extension ExpenseRouter: TargetType {
  var baseURL: URL {
    URL(string: ServerInfo.baseURL)!
  }

  var path: String {
    switch self {
    case .getMonthlyExpenses(let userId):
      return "/expenses/\(userId)"
    case .getSingleExpense(let userId, let expenseId):
      return "/expenses/\(userId)/\(expenseId)"
    case .postAddedExpense:
      return "/expenses/add"
    case .postUpdatedExpenses(let userId):
      return "/expenses/\(userId)"
    }
  }

  var method: Moya.Method {
    switch self {
    case .getMonthlyExpenses, .getSingleExpense:
      return .get
    case .postAddedExpense, .postUpdatedExpenses:
      return .post
    }
  }

  var task: Moya.Task {
    switch self {
    case .getMonthlyExpenses, .getSingleExpense:
      return .requestPlain
    case .postUpdatedExpenses(_, let updatedExpenseRequestDTO):
      return .requestJSONEncodable(updatedExpenseRequestDTO)
    case .postAddedExpense(let addedExpenseRequestDTO):
      return .requestJSONEncodable(addedExpenseRequestDTO)
    }
  }

  var headers: [String: String]? {
    return ["Content-type": "application/json"]
  }
}
