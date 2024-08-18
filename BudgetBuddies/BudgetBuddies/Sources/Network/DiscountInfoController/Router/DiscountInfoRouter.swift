//
//  DiscountInfoRouter.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/9/24.
//

import Foundation
import Moya

enum DiscountInfoRouter {
  case getDiscounts(request: InfoRequest)
}

extension DiscountInfoRouter: TargetType {
  var baseURL: URL {
    return URL(string: ServerInfo.baseURL)!
  }

  var path: String {
    switch self {
    case .getDiscounts:
      return "/discounts"
    }
  }

  var method: Moya.Method {
    switch self {
    case .getDiscounts:
      return .get
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
    }
  }

  var headers: [String: String]? {
    switch self {
    case .getDiscounts:
      return ["Content-type": "application/json"]
    }
  }

}
