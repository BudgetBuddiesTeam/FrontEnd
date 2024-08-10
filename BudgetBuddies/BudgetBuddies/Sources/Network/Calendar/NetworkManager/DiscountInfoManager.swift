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

  typealias DiscountInfoNetworkCompletion = (Result<DiscountsResponse, Error>) -> Void

  func fetchDiscounts(request: InfoRequest, completion: @escaping (DiscountInfoNetworkCompletion)) {
    DiscountInfoProvider.request(.getDiscounts(request: request)) { result in

      switch result {
      case .success(let response):
        print("통신 성공.... 데이터 디코딩 시작")
        do {
          let decoder = JSONDecoder()
          let DiscountsResponse = try decoder.decode(DiscountsResponse.self, from: response.data)
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
}
