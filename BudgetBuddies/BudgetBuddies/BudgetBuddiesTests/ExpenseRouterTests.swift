//
//  ExpenseRouterTests.swift
//  BudgetBuddiesTests
//
//  Created by Jiwoong CHOI on 8/16/24.
//

import Moya
import XCTest

@testable import BudgetBuddies

final class ExpenseRouterTests: XCTestCase {
  var provider: MoyaProvider<ExpenseRouter>!
  var userId: Int!
  var timeoutValue: Double!
  var expectation: XCTestExpectation!

  override func setUp() {
    super.setUp()

    provider = MoyaProvider<ExpenseRouter>()
    userId = 1
    timeoutValue = 10.0
    expectation = self.expectation(description: "Testing asyncronous code")
  }

  // MARK: - 월별 소비 조회 테스트

  /// GET :  /expenses/{userId} 엔드포인트 테스트 메소드
  func testGetMonthlyExpensesEndpoint() {

    // Request Variable
    /*
     해야 할 일
     - 서버에서 사용하는 날짜 형식이 맞지 않다.
     - 어떤 곳에서는 yyyy-MM-ss HH:mm:ss이고 여기 같은 곳에서는 yyyy-MM-ss이다.
     */
    let date = "2024-08-16"

    // Network Transmitting Code
    provider.request(.getMonthlyExpenses(userId: self.userId, date: date)) {
      result in
      defer { self.expectation.fulfill() }

      switch result {
      case .success(let response):
        debugPrint("/expenses/{userId} API 연결 성공")
        debugPrint(response.statusCode)
        XCTAssertEqual(response.statusCode, 200, ErrorMessage.TellsWhatRightStatusCodeIs)
        debugPrint(response.request?.url as Any)

        do {
          let decodedData = try JSONDecoder().decode(
            MonthlyExpenseCompactResponseDto.self, from: response.data)
          debugPrint(decodedData)
        } catch (let error) {
          XCTFail("/expenses/{userId} API에서 가져온 데이터 디코딩 실패 : \(error.localizedDescription)")
        }
      case .failure(let error):
        XCTFail("/expenses/{userId} API 연결 실패 : \(error.localizedDescription)")
      }
    }

    waitForExpectations(timeout: self.timeoutValue) { error in
      if let error = error {
        XCTFail("월별 소비 조회 테스팅 간 에러 발생 : \(error.localizedDescription)")
      }
    }
  }

  // MARK: - 단일 소비 업데이트 테스트

  /// POST : /expenses/{userId} 엔드포인트 테스트
  func testPostUpdatedSingleExpenseEndpoint() {

    // Request Variable
    let expenseUpdateRequestDTO = ExpenseUpdateRequestDTO(
      expenseId: 101, categoryId: 1, expenseDate: "2024-08-21 12:50:00", amount: 96000)

    // Network Transmitting Code
    provider.request(
      .postUpdatedSingleExpense(userId: 1, updatedExpenseRequestDTO: expenseUpdateRequestDTO)
    ) { result in
      defer { self.expectation.fulfill() }

      switch result {
      case .success(let response):
        debugPrint("/expenses/{userId} API 연결 성공")
        debugPrint(response.statusCode)
        XCTAssertEqual(response.statusCode, 200, ErrorMessage.TellsWhatRightStatusCodeIs)
        debugPrint(response.request?.url as Any)
        do {
          let decodedData = try JSONDecoder().decode(ExpenseResponseDTO.self, from: response.data)
          debugPrint(decodedData)
        } catch (let error) {
          XCTFail("/expenses/{userId} API에서 가져온 데이터 디코딩 실패 : \(error.localizedDescription)")
        }
      case .failure(let error):
        XCTFail("/expenses/{userId} API 연결 실패 : \(error.localizedDescription)")
      }
    }
    waitForExpectations(timeout: self.timeoutValue) { error in
      if let error = error {
        XCTFail("단일 소비 업데이트 테스팅 간 에러 발생 : \(error.localizedDescription)")
      }
    }
  }

  // MARK: - 소비 내역 추가 테스트

  /// POST : /expenses/add 엔드포인트 테스트 메소드
  func testPostAddedExpenseEndpoint() {

    // Request Variable
    let sampleNewExpenseRequestDTO = NewExpenseRequestDTO(
      categoryId: 2, amount: 98700, description: "뭐에 거의 10만원이나 썼을까",
      expenseDate: "2024-08-18 00:00:00")

    // Network Transmitting Code
    provider.request(
      .postAddedExpense(userId: self.userId, addedExpenseRequestDTO: sampleNewExpenseRequestDTO)
    ) {
      result in
      defer { self.expectation.fulfill() }

      switch result {
      case .success(let response):
        debugPrint("/expenses/add/{userId} API 연결 성공")
        debugPrint(response.statusCode)
        XCTAssertEqual(response.statusCode, 200, ErrorMessage.TellsWhatRightStatusCodeIs)
        debugPrint(response.request?.url as Any)
        do {
          let decodedData = try JSONDecoder().decode(
            AddedExpenseResponseDTO.self, from: response.data)
          debugPrint("/expenses/add/{userId} API에서 가져온 데이터 디코딩 성공")
          debugPrint(decodedData)
        } catch (let error) {
          XCTFail("/expenses/add/{userId} API에서 가져온 데이터 디코딩 실패 : \(error.localizedDescription)")
        }
      case .failure(let error):
        XCTFail("/expenses/add/{userId} API 연결 실패 : \(error.localizedDescription)")
      }
    }

    waitForExpectations(timeout: self.timeoutValue) { error in
      if let error = error {
        debugPrint("소비 내역 추가 테스팅 간 에러 발생")
        debugPrint(error.localizedDescription)
      }
    }
  }

  // MARK: - 단일 소비 조회 테스트

  /// GET : /expenses/{userId}/{expenseId} 엔드포인트 테스트 메소드
  func testGetSingleExpenseEndpoint() {

    // Request Variable
    let expenseId = 102

    // Network Transmitting Code
    provider.request(.getSingleExpense(userId: self.userId, expenseId: expenseId)) { result in
      defer { self.expectation.fulfill() }

      switch result {
      case .success(let response):
        debugPrint("/expenses/{userId}/{expenseId} API 연결 성공")
        debugPrint(response.statusCode)
        XCTAssertEqual(response.statusCode, 200, ErrorMessage.TellsWhatRightStatusCodeIs)
        debugPrint(response.request?.url as Any)

        do {
          let decodedData = try JSONDecoder().decode(ExpenseResponseDTO.self, from: response.data)
          debugPrint("/expenses/{userId}/{expenseId} API에서 가져온 데이터 디코딩 성공")
          debugPrint(decodedData)
        } catch (let error) {
          XCTFail(
            "/expenses/{userId}/{expenseId} API에서 가져온 데이터 디코딩 실패 : \(error.localizedDescription)")
        }
      case .failure(let error):
        XCTFail("/expenses/{userId}/{expenseId} API 연결 실패 : \(error.localizedDescription)")
      }
    }

    waitForExpectations(timeout: self.timeoutValue) { error in
      if let error = error {
        debugPrint("단일 소비 조회 테스팅 간 에러 발생")
        debugPrint(error.localizedDescription)
      }
    }
  }

  // MARK: - 소비 내역 삭제 테스트

  /// DELETE : /expenses/delete/{expenseId} 엔드포인트 테스트 메소드
  func testDeleteSingleExpenseEndpoint() {

    // Request Variale
    let expenseId = 100

    // Network Transmitting Code
    provider.request(.deleteSingleExpense(expenseId: expenseId)) { result in
      defer { self.expectation.fulfill() }

      switch result {
      case .success(let response):
        debugPrint("/expenses/delete/{expenseId} API 연결 성공")
        debugPrint(response.statusCode)
        XCTAssertEqual(response.statusCode, 200, ErrorMessage.TellsWhatRightStatusCodeIs)
        debugPrint(response.request?.url as Any)

        if let decodedString = String(data: response.data, encoding: .utf8) {
          debugPrint(decodedString)
        } else {
          debugPrint("해당 소비 내역은 정상적으로 제거되었습니다")
        }
      case .failure(let error):
        XCTFail("/expenses/delete/{expenseId} API 연결 실패 : \(error.localizedDescription)")
      }
    }

    waitForExpectations(timeout: self.timeoutValue) { error in
      if let error = error {
        debugPrint("소비 내역 삭제 테스팅 간 에러 발생")
        debugPrint(error.localizedDescription)
      }
    }
  }
}
