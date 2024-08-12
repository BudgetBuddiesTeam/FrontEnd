//
//  SupportInfoManager.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/9/24.
//

import Foundation
import Moya

final class SupportInfoManager {
  static let shared = SupportInfoManager()
  private init() {}

  let SupportInfoProvider = MoyaProvider<SupportInfoRouter>()

  typealias SupportInfoNetworkCompletion = (Result<SupportsResponse, Error>) -> Void

  func fetchSupports(request: InfoRequest, completion: @escaping (SupportInfoNetworkCompletion)) {
    SupportInfoProvider.request(.getSupports(request: request)) { result in

      switch result {
      case .success(let response):
        print("통신 성공.... 데이터 디코딩 시작")
        do {
          let decoder = JSONDecoder()
          let SupportsResponse = try decoder.decode(SupportsResponse.self, from: response.data)
          completion(.success(SupportsResponse))

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
