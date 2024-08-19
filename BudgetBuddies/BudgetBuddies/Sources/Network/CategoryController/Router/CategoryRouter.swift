//
//  CategoryRouter.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/5/24.
//

import Foundation
import Moya

/*
 해야 할 일
 1. addCategory를 사용할 때, userId를 JSON에 담아서 발송하는 방식에서 request 파라미터로 전달하는 방법으로 변경되므로
 해당 사항 반영해서 CategoryRouter 재설계할 것
 */

enum CategoryRouter {
  case addCategory(userId: Int, categoryRequest: CategoryRequestDTO)
  case getCategory(userId: Int)
}

extension CategoryRouter: TargetType {
  var baseURL: URL {
    return URL(string: ServerInfo.baseURLString)!
  }

  var path: String {
    switch self {
    case .addCategory(let userId, _):
      return "/categories/add/\(userId)"
    case .getCategory(let userId):
      return "categories/get/\(userId)"
    }
  }

  var method: Moya.Method {
    switch self {
    case .addCategory:
      return .post
    case .getCategory:
      return .get
    }
  }

  var task: Moya.Task {
    switch self {
    case .addCategory(_, let categoryRequest):
      return .requestJSONEncodable(categoryRequest)
    case .getCategory:
      return .requestPlain
    }
  }

  var headers: [String: String]? {
    return ["Content-type": "application/json"]
  }

}
