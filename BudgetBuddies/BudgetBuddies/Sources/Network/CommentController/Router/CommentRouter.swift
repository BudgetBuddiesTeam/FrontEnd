//
//  CommentRouter.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/17/24.
//

import Foundation
import Moya

enum CommentRouter {
    case getDiscountsComments(userId: Int, request: CommentRequest)
    case getSupportsComments(userId: Int, request: CommentRequest)
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
        case .getDiscountsComments(let userId, _):
            return "/discounts/\(userId)/comments"
            
        case .getSupportsComments(let userId, _):
            return "/supports/\(userId)/comments"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDiscountsComments(let userId, let request):
            return .get
            
        case .getSupportsComments(let userId, let request):
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
