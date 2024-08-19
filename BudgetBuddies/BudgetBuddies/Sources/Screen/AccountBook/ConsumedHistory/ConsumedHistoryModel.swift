//
//  ConsumedHistoryModel.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/19/24.
//

import Foundation
import Moya

/// 소비 내역 모델 데이터
///
/// 모델 데이터를 관심사 분리하고 DI (Depency Injection)을 구현했습니다.
class ConsumedHistoryModel {
  
  // MARK: - Properties

  // Network
  private let provider = MoyaProvider<ExpenseRouter>()
  
  // Variable
  private let userId = 1
  private let currentDateString: String = {
    var formattedCurrentDateString = String()
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: "ko_KR")
    formattedCurrentDateString = dateFormatter.string(from: currentDate)
    return formattedCurrentDateString
  }()
  private var expensesList: [String: [CompactExpenseResponseDto]] = [:]
  
  // MARK: - Initializer

  init() {
    self.getMonthlyExpenseDataFromServer(dateString: self.currentDateString)
  }
  
  // MARK: - Methods
  public func getCurrentDateString() -> String {
    return self.currentDateString
  }
  
  public func getExpenseListCount() -> Int {
    return self.expensesList.count
  }
  
  public func getDailyExpenseListCount(section: Int) -> Int {
    return 0
  }
  
  /// 데이터 모델이 초기화 되면서 먼저 데이터를 불러오기 위한 함수
  private func getMonthlyExpenseDataFromServer(dateString: String) {
    provider.request(
      .getMonthlyExpenses(
        userId: self.userId,
        date: dateString)
    ) { [weak self] result in
      switch result {
      case .success(let response):
        do {
          let decodedData = try JSONDecoder().decode(
            MonthlyExpenseCompactResponseDto.self, from: response.data)
          self?.expensesList = decodedData.expenses
        } catch {
          self?.expensesList = [:]
        }
      case .failure:
        self?.expensesList = [:]
      }
    }
  }
  
  enum NetworkError: Error {
    case decodingError
    case connectionFailedError
  }
  
  /// 월별 소비 조회 메소드
  ///
  /// - Parameters:
  ///   - dateString: 현재 날짜 문자열
  ///   - handler: 네트워크 통신 후 결과에 따른 UX 설계를 위한 핸들러
  public func getMonthlyExpenseDataFromServer(dateString: String, handler: @escaping (_ result: Result<String, NetworkError>) -> Void) {
    provider.request(
      .getMonthlyExpenses(
        userId: userId,
        date: dateString)
    ) { [weak self] result in
      switch result {
      case .success(let response):
        do {
          let decodedData = try JSONDecoder().decode(
            MonthlyExpenseCompactResponseDto.self, from: response.data)
          self?.expensesList = decodedData.expenses
        } catch {
          handler(.failure(.decodingError))
        }
      case .failure:
        handler(.failure(.connectionFailedError))
      }
    }
  }
}
