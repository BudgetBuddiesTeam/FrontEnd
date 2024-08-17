//
//  CommentManager.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/17/24.
//

import Foundation
import Moya

final class CommentManager {
    static let shared = CommentManager()
    private init() {}
    
    let CommentProvider = MoyaProvider<CommentRouter>()
    
    // Result타입 선언
    typealias DiscountsCommentsNetworkCompletion = (Result<DiscountsCommentsResponse, Error>) -> Void
    
    typealias SupportsCommentsNetworkCompletion = (Result<SupportsCommentsResponse, Error>) -> Void
    
    // MARK: - 할인정보 전체 댓글 불러오기
    func fetchDiscountsComments(discountInfoId: Int, request: CommentRequest, completion: @escaping(DiscountsCommentsNetworkCompletion)) {
        CommentProvider.request(.getDiscountsComments(discountInfoId: discountInfoId, request: request)) { result in
            
            switch result {
            case .success(let response):
                print("통신 성공.... 데이터 디코딩 시작")
                do {
                    let decoder = JSONDecoder()
                    let comments = try decoder.decode(DiscountsCommentsResponse.self, from: response.data)
                    completion(.success(comments))
                } catch {
                    print("데이터 디코딩 실패")
                    completion(.failure(error))
                }
                
            case .failure(let error):
                print("통신 에러 발생")
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - 지원정보 전체 댓글 불러오기
    func fetchSupportsComments(supportsInfoId: Int, request: CommentRequest, completion: @escaping(SupportsCommentsNetworkCompletion)) {
        CommentProvider.request(.getSupportsComments(supportInfoId: supportsInfoId, request: request)) { result in
            
            switch result {
            case .success(let response):
                print("통신 성공.... 데이터 디코딩 시작")
                do {
                    let decoder = JSONDecoder()
                    let comments = try decoder.decode(SupportsCommentsResponse.self, from: response.data)
                    completion(.success(comments))
                } catch {
                    print("데이터 디코딩 실패")
                    completion(.failure(error))
                }
                
            case .failure(let error):
                print("통신 에러 발생")
                completion(.failure(error))
            }
        }
    }
}
