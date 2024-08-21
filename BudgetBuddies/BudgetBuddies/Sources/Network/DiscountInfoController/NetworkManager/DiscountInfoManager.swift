//
//  DiscountInfoManager.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/9/24.
//

import Foundation
import Moya

final class DiscountInfoManager {
  static let shared = DiscountInfoManager()
  private init() {}

  let DiscountInfoProvider = MoyaProvider<DiscountInfoRouter>()

  typealias DiscountInfoNetworkCompletion = (Result<DiscountsResponseDTO, Error>) -> Void
    typealias DiscountsLikesNetworkCompletion = (Result<Response, Error>) -> Void

  func fetchDiscounts(
    request: InfoRequestDTO, completion: @escaping (DiscountInfoNetworkCompletion)
  ) {
    DiscountInfoProvider.request(.getDiscounts(request: request)) { result in

      switch result {
      case .success(let response):
        print("통신 성공.... 데이터 디코딩 시작")
        do {
          let decoder = JSONDecoder()
          let DiscountsResponse = try decoder.decode(DiscountsResponseDTO.self, from: response.data)
          completion(.success(DiscountsResponse))

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
    
    func postDiscountsLikes(userId: Int, discountInfoId: Int, completion: @escaping(DiscountsLikesNetworkCompletion)) {
        
        DiscountInfoProvider.request(.postDiscountsLikes(userId: userId, discountInfoId: discountInfoId)) { result in
            
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
