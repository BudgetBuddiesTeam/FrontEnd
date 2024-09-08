//
//  CalendarManager.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/10/24.
//

import Foundation
import Moya

final class CalendarManager {
  static let shared = CalendarManager()
  private init() {}

  let CalendarProvider = MoyaProvider<CalendarRouter>()

  typealias CalendarNetworkCompletion = (Result<CalendarResponseDTO, Error>) -> Void

  func fetchCalendar(request: YearMonth, completion: @escaping (CalendarNetworkCompletion)) {
    CalendarProvider.request(.getCalendar(request: request)) { result in

      switch result {
      case .success(let response):
        print("통신 성공.... 데이터 디코딩 시작")
        do {
          let decoder = JSONDecoder()
          let CalendarResponse = try decoder.decode(CalendarResponseDTO.self, from: response.data)
          completion(.success(CalendarResponse))

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
