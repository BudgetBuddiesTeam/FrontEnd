//
//  CategoryRouter.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/5/24.
//

import Foundation
import Moya

enum CategoryRouter {
  case addCategory(categoryRequest: CategoryRequest)
  case getCategory(userID: String, categoryResponse: CategoryResponse)
}

extension CategoryRouter : TargetType {
  var baseURL: URL {
    return URL(string: ServerInfo.baseURL)!
  }
  
  var path: String {
    switch self {
    case .addCategory:
      return "/add"
    case .getCategory(let userID, _):
      return "/get/\(userID)"
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
    case let .addCategory(categoryRequest):
      return .requestJSONEncodable(categoryRequest)
    case .getCategory:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    return ["Content-type": "application/json"]
  }
  
  
}
