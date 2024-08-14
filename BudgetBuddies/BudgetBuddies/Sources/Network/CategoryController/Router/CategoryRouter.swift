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
  case addCategory(categoryRequest: CategoryRequestDTO)
  case getCategoryWithPathVariable(userId:Int)
  case getCategoryWithRequestParameter(userId: Int)
}

extension CategoryRouter: TargetType {
  var baseURL: URL {
    return URL(string: ServerInfo.baseURL)!
  }

  var path: String {
    switch self {
    case .addCategory:
      return "/categories/add"
    case .getCategoryWithPathVariable(let userId):
      return "categories/get/\(userId)"
    case .getCategoryWithRequestParameter:
      return "/categories/get"
    }
  }

  var method: Moya.Method {
    switch self {
    case .addCategory:
      return .post
    case .getCategoryWithRequestParameter, .getCategoryWithPathVariable:
      return .get
    }
  }

  var task: Moya.Task {
    switch self {
    case .addCategory(let categoryRequest):
      return .requestJSONEncodable(categoryRequest)
    case .getCategoryWithPathVariable:
      return .requestPlain
    case .getCategoryWithRequestParameter(let userId):
      return .requestParameters(parameters: ["userId": userId], encoding: URLEncoding.queryString)
    }
  }

  var headers: [String: String]? {
    return ["Content-type": "application/json"]
  }

}
