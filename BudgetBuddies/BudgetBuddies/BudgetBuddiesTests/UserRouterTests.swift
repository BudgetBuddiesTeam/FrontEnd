//
//  UserRouterTests.swift
//  BudgetBuddiesTests
//
//  Created by Jiwoong CHOI on 8/16/24.
//

import Moya
import XCTest

@testable import BudgetBuddies

final class UserRouterTests: XCTestCase {

  var provider: MoyaProvider<UserRouter>!
  var timeoutValue: Double!
  var expectation: XCTestExpectation!
  var userId: Int!

  override func setUp() {
    super.setUp()

    provider = MoyaProvider<UserRouter>()
    timeoutValue = 10.0
    expectation = self.expectation(description: "Testing asynchronous methods")
    userId = 1
  }

  // MARK: - 사용자 데이터 변경

  /// /users/modify/{userId} 엔드포인트 테스트 메소드
  func testModify() {

    // Request Variable
    let email = "budgetbuddies@gmail.com"
    let name = "빈주머니즈"

    let userInfoRequestDTO = UserInfoRequestDTO(email: email, name: name)

    // Network Transmitting Code
    provider.request(.modify(userId: self.userId, userInfoRequestDTO: userInfoRequestDTO)) {
      result in
      defer { self.expectation.fulfill() }

      switch result {
      case .success(let response):
        debugPrint("/users/modify/{userId} API 연결 성공")
        debugPrint(response.statusCode)
        XCTAssertEqual(response.statusCode, 200, ErrorMessage.TellsWhatRightStatusCodeIs)
        debugPrint(response.request?.url as Any)

        do {
          let decodedData = try JSONDecoder().decode(
            ApiResponseResponseUserDto.self, from: response.data)
          debugPrint("/users/modify/{userId} API에서 가져온 데이터 디코딩 성공")
          debugPrint(decodedData)
        } catch (let error) {
          XCTFail("/users/modify/{userId} API에서 가져온 데이터 디코딩 실패 : \(error.localizedDescription)")
        }
      case .failure(let error):
        XCTFail("/users/modify/{userId} API 연결 실패 : \(error.localizedDescription)")
      }
    }

    waitForExpectations(timeout: self.timeoutValue) { error in
      if let error = error {
        XCTFail("사용자 정보 수정 API 테스팅 간 에러 발생 : \(error.localizedDescription)")
      }
    }
  }

  // MARK: - 사용자 찾기

  func testFind() {
    // Network Transmitting Code
    provider.request(.find(userId: self.userId)) { result in
      defer { self.expectation.fulfill() }

      switch result {
      case .success(let response):
        debugPrint("/users/{userId}/find API 연결 성공")
        debugPrint(response.statusCode)
        XCTAssertEqual(response.statusCode, 200, ErrorMessage.TellsWhatRightStatusCodeIs)
        debugPrint(response.request?.url as Any)
        do {
          let decodedData = try JSONDecoder().decode(
            ApiResponseResponseUserDto.self, from: response.data)
          debugPrint("/users/{userId}/find API에서 가져온 데이터 디코딩 성공")
          debugPrint(decodedData)
        } catch (let error) {
          XCTFail("/users/{userId}/find API에서 가져온 데이터 디코딩 실패 : \(error.localizedDescription)")
        }
      case .failure(let error):
        XCTFail("/users/{userId}/find API 연결 실패 : \(error.localizedDescription)")
      }
    }

    waitForExpectations(timeout: self.timeoutValue) { error in
      if let error = error {
        XCTFail("사용자 정보 찾기 API 테스팅 간 에러 발생 : \(error.localizedDescription)")
      }
    }
  }
}
