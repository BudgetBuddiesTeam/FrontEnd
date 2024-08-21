//
//  DiscountInfoRouter.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/9/24.
//

import Foundation
import Moya

enum DiscountInfoRouter {
  case getDiscounts(request: InfoRequestDTO)
    case postDiscountsLikes(userId: Int, discountInfoId: Int)
}

extension DiscountInfoRouter: TargetType {
  var baseURL: URL {
    return URL(string: ServerInfo.baseURLString)!
  }

  var path: String {
    switch self {
    case .getDiscounts:
      return "/discounts"
        
    case .postDiscountsLikes(_, discountInfoId: let discountInfoId):
        return "/discounts/likes/\(discountInfoId)"
    }
  }

  var method: Moya.Method {
    switch self {
    case .getDiscounts:
      return .get
        
    case .postDiscountsLikes:
        return .post
    }
  }

  var task: Moya.Task {
    switch self {
    case .getDiscounts(let request):
      let parameters: [String: Any] = [
        "year": request.year,
        "month": request.month,
        "page": request.page,
        "size": request.size,
      ]
      return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        
    case .postDiscountsLikes(userId: let userId, _):
        let parameters: [String: Any] = [
            "userId": userId
        ]
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
  }

  var headers: [String: String]? {
      return ["Content-type": "application/json"]
  }

}
