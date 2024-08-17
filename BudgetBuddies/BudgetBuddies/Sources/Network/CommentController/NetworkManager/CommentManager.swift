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
    typealias DiscountsCommentsNetworkCompletion = (Result<DiscountsCommentsResponseDTO, Error>) -> Void
    typealias SupportsCommentsNetworkCompletion = (Result<SupportsCommentsResponseDTO, Error>) -> Void
    typealias postCommentsNetworkCompletion = (Result<Response, Error>) -> Void
    
    // MARK: - 할인정보 전체 댓글 불러오기
    func fetchDiscountsComments(discountInfoId: Int, request: CommentRequest, completion: @escaping(DiscountsCommentsNetworkCompletion)) {
        CommentProvider.request(.getDiscountsComments(discountInfoId: discountInfoId, request: request)) { result in
            
            switch result {
            case .success(let response):
                print("통신 성공.... 데이터 디코딩 시작")
                do {
                    let decoder = JSONDecoder()
                    let comments = try decoder.decode(DiscountsCommentsResponseDTO.self, from: response.data)
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
                    let comments = try decoder.decode(SupportsCommentsResponseDTO.self, from: response.data)
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
    
    // MARK: - 할인정보 댓글 쓰기
    // 여기 설계하면서 느낀 건데, post는 굳이 매니저로 관리하지 않아도 될 거 같은 느낌이 듭니다.
    func postDiscountsComments(userId: Int, request: DiscountsCommentsRequestDTO, completion: @escaping(postCommentsNetworkCompletion)) {
        CommentProvider.request(.addDiscountsComments(userId: userId, request: request)) { result in
            switch result {
            case .success(let response):
                print("통신 성공")
                completion(.success(response))
            case .failure(let error):
                print("통신 에러 발생")
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - 지원정보 댓글 쓰기
    func postSupportsComments(userId: Int, request: SupportsCommentsRequestDTO, completion: @escaping(postCommentsNetworkCompletion)) {
        CommentProvider.request(.addSupportsComments(userId: userId, request: request)) { result in
            switch result {
            case .success(let response):
                print("통신 성공")
                completion(.success(response))
            case .failure(let error):
                print("통신 에러 발생")
                completion(.failure(error))
            }
        }
    }
}
