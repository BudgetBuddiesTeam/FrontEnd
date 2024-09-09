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

  typealias SupportInfoNetworkCompletion = (Result<SupportsResponseDTO, Error>) -> Void
  typealias SupportsLikesNetworkCompletion = (Result<SupportOneResponseDTO, Error>) -> Void

  func fetchSupports(request: InfoRequestDTO, completion: @escaping (SupportInfoNetworkCompletion))
  {
    SupportInfoProvider.request(.getSupports(request: request)) { result in

      switch result {
      case .success(let response):
        print("통신 성공.... 데이터 디코딩 시작")
        do {
          let decoder = JSONDecoder()
          let supportsResponse = try decoder.decode(SupportsResponseDTO.self, from: response.data)
          completion(.success(supportsResponse))

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

  func postSupportsLikes(
    userId: Int, supportInfoId: Int, completion: @escaping (SupportsLikesNetworkCompletion)
  ) {

    SupportInfoProvider.request(.postSupportsLikes(userId: userId, supportInfoId: supportInfoId)) {
      result in

      switch result {
      case .success(let response):
        print("통신 성공")
        do {
          let decoder = JSONDecoder()
          let supportOneResponse = try decoder.decode(
            SupportOneResponseDTO.self, from: response.data)
          completion(.success(supportOneResponse))
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
