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
  private var monthlyExpenseResponseData: MonthlyExpenseResponseDto?

  // MARK: - Initializer

  init() {
    self.getMonthlyExpenseDataFromServer()
  }

  // MARK: - Methods

  /// 서버에서 받아온 데이터의 Month 값 반환 메소드
  ///
  /// 데이터를 가져오지 못했을 때는 0 값으로 반환합니다.
  public func getDataMonth() -> Int {
    if let expenseMonth = self.monthlyExpenseResponseData?.expenseMonth {
      let inputDateFormatter = DateFormatter()
      inputDateFormatter.dateFormat = "yyyy-MM-dd"

      let outputDateFormatter = DateFormatter()
      outputDateFormatter.dateFormat = "M"

      if let date = inputDateFormatter.date(from: expenseMonth),
        let dateNumber = Int(outputDateFormatter.string(from: date))
      {
        return dateNumber
      } else {
        return 0
      }
    } else {
      return 0
    }
  }

  /// 현재 날짜 데이터를 문자열로 반환합니다
  public func getCurrentDateString() -> String {
    return self.currentDateString
  }

  /// 해당 월의 날짜의 개수
  ///
  /// 28일, 29일, 30일, 31일 중 하나의 값 반환 메소드
  public func getDaysInMonth() -> Int {
    let calendar = Calendar.current
    let date = Date()

    guard let range = calendar.range(of: .day, in: .month, for: date) else { return 0 }

    return range.count
  }

  public func getSpentDaysCountInMonth() -> Int {
    if let spentDaysCount = self.monthlyExpenseResponseData?.dailyExpenses.count {
      return spentDaysCount
    } else {
      return 0
    }
  }

  public func getSpentDaysInfo(section: Int) -> DailyExpenseResponseDto {
    if let dailyExpenses = self.monthlyExpenseResponseData?.dailyExpenses[section] {
      return dailyExpenses
    } else {
      /*
       해야 할 일
       - 데이터가 없을 때 전달하는 목업 데이터 생성
       */
      return DailyExpenseResponseDto(daysOfMonth: 0, daysOfTheWeek: "N요일", expenses: [])
    }
  }

  public func getDailyExpenses(section: Int) -> [CompactExpenseResponseDto] {
    if let expense = self.monthlyExpenseResponseData?.dailyExpenses[section].expenses {
      return expense
    } else {
      /*
       해야 할 일
       - 데이터가 없을 때 전달하는 목업 데이터 생성
       */
      return []
    }
  }

  /// 종합 소비 금액 데이터 반환 메소드
  ///
  /// 서버에서 데이터를 가져오지 못한다면, 0원 데이터를 반환합니다.
  public func getTotalConsumptionAmount() -> Int {
    if let totalConsumptionAmount = self.monthlyExpenseResponseData?.totalConsumptionAmount {
      return totalConsumptionAmount
    } else {
      return 0
    }
  }

  /// 데이터 모델이 초기화 되면서 먼저 데이터를 서버에서 가져오는 메소드
  private func getMonthlyExpenseDataFromServer() {
    provider.request(
      .getMonthlyExpenses(
        userId: self.userId,
        date: self.currentDateString)
    ) { [weak self] result in
      switch result {
      case .success(let response):
        do {
          let decodedData = try JSONDecoder().decode(
            MonthlyExpenseResponseDto.self, from: response.data)
          self?.monthlyExpenseResponseData = decodedData
        } catch {
          // MonthlyExpenseResponseData에 빈 데이터 넣기
          self?.monthlyExpenseResponseData = MonthlyExpenseResponseDto(
            expenseMonth: "", totalConsumptionAmount: 0,
            dailyExpenses: [
              DailyExpenseResponseDto(
                daysOfMonth: 0, daysOfTheWeek: "",
                expenses: [
                  CompactExpenseResponseDto(expenseId: 0, description: "", amount: 0, categoryId: 0)
                ])
            ])
        }
      case .failure:
        // MonthlyExpenseResponseData에 빈 데이터 넣기
        self?.monthlyExpenseResponseData = MonthlyExpenseResponseDto(
          expenseMonth: "", totalConsumptionAmount: 0,
          dailyExpenses: [
            DailyExpenseResponseDto(
              daysOfMonth: 0, daysOfTheWeek: "",
              expenses: [
                CompactExpenseResponseDto(expenseId: 0, description: "", amount: 0, categoryId: 0)
              ])
          ])
      }
    }
  }

  /// 모델에서 네트워크 처리에 대한 결과를 컨트롤러에서 UX 핸들링 하기 위한 에러 케이스
  enum NetworkError: Error {
    case decodingError
    case connectionFailedError
  }

  /// 월별 소비 조회 메소드
  ///
  /// - Parameters:
  ///   - handler: 네트워크 통신 후 결과에 따른 UX 설계를 위한 핸들러
  public func getMonthlyExpenseDataFromServer(
    handler: @escaping (_ result: Result<String, NetworkError>) -> Void
  ) {
    provider.request(
      .getMonthlyExpenses(
        userId: self.userId,
        date: self.currentDateString)
    ) { [weak self] result in
      switch result {
      case .success(let response):
        do {
          let decodedData = try JSONDecoder().decode(
            MonthlyExpenseResponseDto.self, from: response.data)
          self?.monthlyExpenseResponseData = decodedData
          handler(.success("서버에서 데이터를 불러옵니다"))
        } catch {
          handler(.failure(.decodingError))
        }
      case .failure:
        handler(.failure(.connectionFailedError))
      }
    }
  }

  /// 해당 월을 제외한 다른 날짜 월별 소비 조회 메소드
  ///
  /// - Parameters:
  ///   - dateString: 가져오고 싶은 날짜 문자열
  ///   - handler: 네트워크 통신 후 결과에 따른 UX 설계를 위한 핸들러
  public func getMonthlyExpenseDataFromServer(
    dateString: String, handler: @escaping (_ result: Result<String, NetworkError>) -> Void
  ) {
    provider.request(
      .getMonthlyExpenses(
        userId: self.userId,
        date: dateString)
    ) { [weak self] result in
      switch result {
      case .success(let response):
        do {
          let decodedData = try JSONDecoder().decode(
            MonthlyExpenseResponseDto.self, from: response.data)
          self?.monthlyExpenseResponseData = decodedData
        } catch {
          handler(.failure(.decodingError))
        }
      case .failure:
        handler(.failure(.connectionFailedError))
      }
    }
  }
}
