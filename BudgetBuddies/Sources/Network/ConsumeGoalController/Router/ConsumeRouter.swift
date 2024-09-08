//
//  ConsumeRouter.swift
//  BudgetBuddies
//
//  Created by 이승진 on 8/11/24.
//

import Foundation
import Moya

enum ConsumeRouter {
  case getConsumeGoal(date: String, userId: Int)
  case postConsumeGoal(userId: Int, consumeRequest: ConsumeRequest)
  case getTopGoal(userId: Int, peerAgeStart: Int, peerAgeEnd: Int, peerGender: String)
  case getTopGoals(userId: Int, peerAgeStart: Int, peerAgeEnd: Int, peerGender: String)
  case getTopConsumption(userId: Int, peerAgeStart: Int, peerAgeEnd: Int, peerGender: String)
  case getTopConsumptions(userId: Int, peerAgeStart: Int, peerAgeEnd: Int, peerGender: String)
  case getTopUser(userId: Int)
  case getPeerInfo(userId: Int, peerAgeStart: Int, peerAgeEnd: Int, peerGender: String)
}

extension ConsumeRouter: TargetType {
  var baseURL: URL {
    URL(string: ServerInfo.baseURLString)!
  }

  var path: String {
    switch self {
    case .getConsumeGoal(_, let userId):
      return ConsumeAPI.getConsumeGoal(userId).apiDesc
    case .postConsumeGoal(let userId, _):
      return ConsumeAPI.postConsumeGoal(userId).apiDesc
    case .getTopGoal(_, _, _, _):
      return ConsumeAPI.getTopGoal.apiDesc
    case .getTopGoals(_, _, _, _):
      return ConsumeAPI.getTopGoals.apiDesc
    case .getTopConsumption(_, _, _, _):
      return ConsumeAPI.getTopConsumption.apiDesc
    case .getTopConsumptions(_, _, _, _):
      return ConsumeAPI.getTopConsumptions.apiDesc
    case .getTopUser(_):
      return ConsumeAPI.getTopUser.apiDesc
    case .getPeerInfo(_, _, _, _):
      return ConsumeAPI.getPeerInfo.apiDesc
    }
  }

  var method: Moya.Method {
    switch self {
    case .getConsumeGoal,
      .getTopGoal,
      .getTopGoals,
      .getTopConsumption,
      .getTopConsumptions,
      .getTopUser,
      .getPeerInfo:
      return .get
    case .postConsumeGoal:
      return .post
    }
  }

  var task: Moya.Task {
    switch self {
    case .getConsumeGoal(let date, _):
      let parameters: [String: Any] = [
        "date": date
      ]
      return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)

    case .postConsumeGoal(_, let consumeRequest):
      return .requestJSONEncodable(consumeRequest)

    case .getTopGoal(let userId, let peerAgeStart, let peerAgeEnd, let peerGender):
      let parameters: [String: Any] = [
        "userId": userId,
        "peerAgeStart": peerAgeStart,
        "peerAgeEnd": peerAgeEnd,
        "peerGender": peerGender,
      ]
      return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)

    case .getTopGoals(let userId, let peerAgeStart, let peerAgeEnd, let peerGender):
      let parameters: [String: Any] = [
        "userId": userId,
        "peerAgeStart": peerAgeStart,
        "peerAgeEnd": peerAgeEnd,
        "peerGender": peerGender,
      ]
      return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)

    case .getTopConsumption(let userId, let peerAgeStart, let peerAgeEnd, let peerGender):
      let parameters: [String: Any] = [
        "userId": userId,
        "peerAgeStart": peerAgeStart,
        "peerAgeEnd": peerAgeEnd,
        "peerGender": peerGender,
      ]
      return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)

    case .getTopConsumptions(let userId, let peerAgeStart, let peerAgeEnd, let peerGender):
      let parameters: [String: Any] = [
        "userId": userId,
        "peerAgeStart": peerAgeStart,
        "peerAgeEnd": peerAgeEnd,
        "peerGender": peerGender,
      ]
      return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)

    case .getTopUser(let userId):
      let parameters: [String: Any] = [
        "userId": userId
      ]
      return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)

    case .getPeerInfo(let userId, let peerAgeStart, let peerAgeEnd, let peerGender):
      let parameters: [String: Any] = [
        "userId": userId,
        "peerAgeStart": peerAgeStart,
        "peerAgeEnd": peerAgeEnd,
        "peerGender": peerGender,
      ]
      return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
  }

  var headers: [String: String]? {
    return ["Content-type": "application/json"]
  }
}
