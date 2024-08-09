//
//  SupportInfoRouter.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/9/24.
//

import Foundation
import Moya

// 입력할 파라미터 값
// 일단 여기다 구현해놓고, 나중에 빼야할 듯
struct InfoRequest {
    let year: Int
    let month: Int
    let page: Int
    let size: Int
}

enum SupportInfoRouter {
    case getSupports(request: InfoRequest)
}

extension SupportInfoRouter: TargetType {
    
    // 기본 도메인 작성
    var baseURL: URL {
        return URL(string: "http://54.180.148.40:8080")!
    }
    
    // path 작성
    var path: String {
        switch self { // 여기서 {id}필요하면 사용
        case .getSupports:
            return "/supports"
        }
    }
    
    // 어떤 방식으로 통신
    var method: Moya.Method {
        switch self {
        case .getSupports:
            return .get
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
                "size": request.size
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    // 헤더값 (고정)
    var headers: [String : String]? {
        switch self {
        case .getSupports:
            return ["Content-type": "application/json"]
        }
    }
    
}


