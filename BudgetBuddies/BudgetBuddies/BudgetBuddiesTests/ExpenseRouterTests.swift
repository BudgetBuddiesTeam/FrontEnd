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
    let pageable = Pageable(page: 0, size: 100)
    let date = "2024-08-16"

    // Network Transmitting Code
    provider.request(.getMonthlyExpenses(userId: self.userId, pageable: pageable, date: date)) {
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
            MonthlyExpenseResponseDTO.self, from: response.data)
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
      expenseId: 3, categoryId: 2, expenseDate: "2024-08-16 12:50:00", amount: 6000)

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
    let sampleAddedExpenseRequestDTO = AddedExpenseRequestDTO(
      userId: self.userId, categoryId: 1, amount: 50000, description: "스타벅스 5만원 충전",
      expenseDate: "2024-08-16 11:22:00")

    // Network Transmitting Code
    provider.request(.postAddedExpense(addedExpenseRequestDTO: sampleAddedExpenseRequestDTO)) {
      result in
      defer { self.expectation.fulfill() }

      switch result {
      case .success(let response):
        debugPrint("/expenses/add API 연결 성공")
        debugPrint(response.statusCode)
        XCTAssertEqual(response.statusCode, 200, ErrorMessage.TellsWhatRightStatusCodeIs)
        debugPrint(response.request?.url as Any)
        do {
          let decodedData = try JSONDecoder().decode(
            AddedExpenseResponseDTO.self, from: response.data)
          debugPrint("/expenses/add API에서 가져온 데이터 디코딩 성공")
          debugPrint(decodedData)
        } catch (let error) {
          XCTFail("/expenses/add API에서 가져온 데이터 디코딩 실패 : \(error.localizedDescription)")
        }
      case .failure(let error):
        XCTFail("/expenses/add API 연결 실패 : \(error.localizedDescription)")
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
    let expenseId = 43

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
    let expenseId = 93

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
