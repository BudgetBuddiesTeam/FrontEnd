//
//  UserRouter.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/16/24.
//

import Foundation
import Moya

enum UserRouter {

  ///
  case modify(userId: Int, userInfoRequestDTO: UserInfoRequestDTO)

  ///
  case addConsumptionGoal(userId: Int)

  ///
  case register(registerUserDTO: RegisterUserDTO)

  ///
  case find(userId: Int)
}

extension UserRouter: TargetType {
  var baseURL: URL {
    return URL(string: ServerInfo.baseURLString)!
  }

  var path: String {
    switch self {
    case .modify(let userId, _):
      return "/users/modify/\(userId)"
    case .addConsumptionGoal(let userId):
      return "/users/\(userId)/add/default-categories/consumption-goal"
    case .register:
      return "/users/register"
    case .find(let userId):
      return "/users/find/\(userId)"
    }
  }

  var method: Moya.Method {
    switch self {
    case .modify:
      return .put
    case .addConsumptionGoal:
      return .post
    case .register:
      return .post
    case .find:
      return .get
    }
  }

  var task: Moya.Task {
    switch self {
    case .modify(_,let userInfoRequestDTO):
      return .requestJSONEncodable(userInfoRequestDTO)
    case .addConsumptionGoal:
      return .requestPlain
    case .register(let registerUserDTO):
      return .requestJSONEncodable(registerUserDTO)
    case .find:
      return .requestPlain
    }
  }

  var headers: [String: String]? {
    return ["Content-type": "application/json"]
  }
}
