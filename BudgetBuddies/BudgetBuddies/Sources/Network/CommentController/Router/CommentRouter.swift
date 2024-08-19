//
//  CommentRouter.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/17/24.
//

import Foundation
import Moya

enum CommentRouter {
  case getDiscountsComments(discountInfoId: Int, request: PostCommentRequest)
  case getSupportsComments(supportInfoId: Int, request: PostCommentRequest)
  case addDiscountsComments(userId: Int, request: DiscountsCommentsRequestDTO)
  case addSupportsComments(userId: Int, request: SupportsCommentsRequestDTO)
  case deleteComments(commentId: Int)
  case getOneDiscountsComments(commentId: Int)
  case getOneSupportsComments(commentId: Int)
    case putDiscountsComments(request: PutCommentRequest)
    case putSupportsComments(request: PutCommentRequest)
}

extension CommentRouter: TargetType {
  var baseURL: URL {
    return URL(string: ServerInfo.baseURLString)!
  }

  var path: String {
    switch self {
    case .getDiscountsComments(let discountInfoId, _):
      return "/discounts/\(discountInfoId)/comments"

    case .getSupportsComments(let supportInfoId, _):
      return "/supports/\(supportInfoId)/comments"

    case .addDiscountsComments:
      return "discounts/comments"

    case .addSupportsComments:
      return "supports/comments"

    case .deleteComments(let commentId):
      return "comments/delete/\(commentId)"

    case .getOneDiscountsComments(let commentId):
      return "discounts/comments/getOne/\(commentId)"

    case .getOneSupportsComments(let commentId):
      return "supports/comments/getOne/\(commentId)"
        
    case .putDiscountsComments:
        return "discounts/comments/modify"
        
    case .putSupportsComments:
        return "supports/comments/modify"
    }
  }

  var method: Moya.Method {
    switch self {
    case .getDiscountsComments:
      return .get

    case .getSupportsComments:
      return .get

    case .addDiscountsComments:
      return .post

    case .addSupportsComments:
      return .post

    case .deleteComments:
      return .delete

    case .getOneDiscountsComments:
      return .get

    case .getOneSupportsComments:
      return .get
        
    case .putDiscountsComments:
        return .put
        
    case .putSupportsComments:
        return .put
    }
  }

  var task: Moya.Task {
    switch self {
    case .getDiscountsComments(_, let request):
      let parameters: [String: Any] = [
        "page": request.page,
        "size": request.size,
      ]
      return .requestParameters(parameters: parameters, encoding: URLEncoding.default) // url에 담아 보내기

    case .getSupportsComments(_, let request):
      let parameters: [String: Any] = [
        "page": request.page,
        "size": request.size,
      ]
      return .requestParameters(parameters: parameters, encoding: URLEncoding.default)

    case .addDiscountsComments(let userId, let request):
      return .requestCompositeParameters(
        bodyParameters: try! request.asDictionary(),
        bodyEncoding: JSONEncoding.default,
        urlParameters: ["userId": userId]
      )

    case .addSupportsComments(let userId, let request):
      return .requestCompositeParameters(
        bodyParameters: try! request.asDictionary(),
        bodyEncoding: JSONEncoding.default,
        urlParameters: ["userId": userId]
      )

    case .deleteComments:
      return .requestPlain

    case .getOneDiscountsComments:
      return .requestPlain

    case .getOneSupportsComments:
      return .requestPlain
        
    case .putDiscountsComments(request: let request):
        let parameters: [String: Any] = [
            "content": request.content,
            "commentId": request.commentId
        ]
        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default) // 바디에 담아 보내기
        
    case .putSupportsComments(request: let request):
        let parameters: [String: Any] = [
            "content": request.content,
            "commentId": request.commentId
        ]
        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
    }
  }

  var headers: [String: String]? {
    return ["Content-type": "application/json"]
  }

}
