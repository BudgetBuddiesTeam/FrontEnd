//
//  SupportInfoRouter.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/9/24.
//

import Foundation
import Moya

// 입력할 파라미터 값

enum SupportInfoRouter {
  case getSupports(request: InfoRequestDTO)
    case postSupportsLikes(userId: Int, supportInfoId: Int)
}

extension SupportInfoRouter: TargetType {

  // 기본 도메인 작성
  var baseURL: URL {
    return URL(string: ServerInfo.baseURLString)!
  }

  // path 작성
  var path: String {
    switch self {  // 여기서 {id}필요하면 사용
    case .getSupports:
      return "/supports"
    
    case .postSupportsLikes(_, supportInfoId: let supportInfoId):
        return "/supports/likes/\(supportInfoId)"
    }
  }

  // 어떤 방식으로 통신
  var method: Moya.Method {
    switch self {
    case .getSupports:
      return .get
        
    case .postSupportsLikes:
        return .post
    }
  }

  // 어떻게 데이터를 전송 할 것인지
  var task: Moya.Task {
    switch self {
    case .getSupports(let request):
      let parameters: [String: Any] = [
        "year": request.year,
        "month": request.month,
        "page": request.page,
        "size": request.size,
      ]
      return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        
    case .postSupportsLikes(userId: let userId, supportInfoId: let supportInfoId):
        let parameters: [String: Any] = [
            "userId": userId
        ]
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
  }

  // 헤더값 (고정)
  var headers: [String: String]? {
      return ["Content-type": "application/json"]
  }

}
