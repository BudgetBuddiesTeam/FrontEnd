//
//  MainRouter.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/11/24.
//

import Foundation
import Moya

enum MainRouter {
  case get(userId: Int)
}

extension MainRouter: TargetType {
  var baseURL: URL {
    URL(string: ServerInfo.baseURLString)!
  }

  var path: String {
    switch self {
    case .get:
      return "/main"
    }
  }

  var method: Moya.Method {
    switch self {
    case .get:
      return .get
    }
  }

  var task: Moya.Task {
    switch self {
    case let .get(userId):
      return .requestParameters(parameters: ["userId": userId], encoding: URLEncoding.queryString)
    }
  }

  var headers: [String: String]? {
    return ["Content-type": "application/json"]
  }
}
