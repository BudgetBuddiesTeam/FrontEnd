//
//  CalendarRouter.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/10/24.
//

import Foundation
import Moya

enum CalendarRouter {
  case getCalendar(request: YearMonth)
}

extension CalendarRouter: TargetType {
  var baseURL: URL {
    return URL(string: ServerInfo.baseURL)!
  }

  var path: String {
    switch self {
    case .getCalendar:
      return "/calendar"
    }
  }

  var method: Moya.Method {
    switch self {
    case .getCalendar:
      return .get
    }
  }

  var task: Moya.Task {
    switch self {
    case .getCalendar(let request):
      let parameters: [String: Any] = [
        // 일단 강제 언래핑
        "year": request.year!,
        "month": request.month!,
      ]
      return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
  }

  var headers: [String: String]? {
    switch self {
    case .getCalendar:
      return ["Content-type": "application/json"]
    }
  }

}
