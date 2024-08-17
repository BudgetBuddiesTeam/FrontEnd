//
//  CommentRouter.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/17/24.
//

import Foundation
import Moya

enum CommentRouter {
    case getDiscountsComments(discountInfoId: Int, request: CommentRequest)
    case getSupportsComments(supportInfoId: Int, request: CommentRequest)
}

extension CommentRouter: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.baseURL)!
    }
    // http://54.180.148.40:8080/discounts?year=2024&month=08&page=0&size=10
    // http://54.180.148.40:8080/discounts/1/comments?page=0&size=20
    // http://54.180.148.40:8080/supports/1/comments?page=0&size=20
    var path: String {
        switch self {
        case .getDiscountsComments(let discountInfoId, _):
            return "/discounts/\(discountInfoId)/comments"
            
        case .getSupportsComments(let supportInfoId, _):
            return "/supports/\(supportInfoId)/comments"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDiscountsComments:
            return .get
            
        case .getSupportsComments:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getDiscountsComments(_, let request):
            let parameters: [String: Any] = [
                "page": request.page,
                "size": request.size
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case .getSupportsComments(_, let request):
            let parameters: [String: Any] = [
                "page": request.page,
                "size": request.size
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
