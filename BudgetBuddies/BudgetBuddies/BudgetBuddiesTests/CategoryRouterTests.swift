//
//  CategoryRouterTests.swift
//  BudgetBuddiesTests
//
//  Created by Jiwoong CHOI on 8/16/24.
//

import Moya
import XCTest

@testable import BudgetBuddies

final class CategoryRouterTests: XCTestCase {

  var provider: MoyaProvider<CategoryRouter>!
  var userId: Int!
  var timeoutValue: Double!
  var expectation: XCTestExpectation!

  override func setUp() {
    super.setUp()

    provider = MoyaProvider<CategoryRouter>()
    userId = 1
    timeoutValue = 10.0
    expectation = self.expectation(description: "Testing asyncronous code")
  }

  // MARK: - 카테고리 추가

  /// /categories/add/{userId} 엔드포인트 테스트 메소드
  func testAddCategory() {
    // Request Variable
    let categoryRequestDTO = CategoryRequestDTO(
      userID: self.userId, name: "프론트엔드 화이팅", isDefault: false)

    // Network Transmitting Code
    provider.request(.addCategory(userId: self.userId, categoryRequest: categoryRequestDTO)) {
      result in
      defer { self.expectation.fulfill() }

      switch result {
      case .success(let response):
        debugPrint("/categories/add/{userId} API 연결 성공")
        debugPrint(response.statusCode)
        XCTAssertEqual(response.statusCode, 200, ErrorMessage.TellsWhatRightStatusCodeIs)
        debugPrint(response.request?.url as Any)

        do {
          let decodedData = try JSONDecoder().decode(CategoryResponseDTO.self, from: response.data)
          debugPrint("/categories/add/{userId} API에서 가져온 데이터 디코딩 성공")
          debugPrint(decodedData)
        } catch (let error) {
          XCTFail("/categories/add/{userId} API에서 가져온 데이터 디코딩 실패 : \(error.localizedDescription)")
        }
      case .failure(let error):
        XCTFail("/categories/add{userId} API 연결 실패 : \(error.localizedDescription)")
      }
    }

    waitForExpectations(timeout: self.timeoutValue) { error in
      if let error = error {
        XCTFail("카테고리 추가 테스팅 간 에러 발생 : \(error.localizedDescription)")
      }
    }
  }

  // MARK: - 카테고리 조회

  /// /categories/get/{userId} 엔드포인트 테스트 메소드
  func testGetCategory() {

    // Request Variable
    // - none

    // Network Transmitting Code
    provider.request(.getCategory(userId: self.userId)) { result in
      defer { self.expectation.fulfill() }

      switch result {
      case .success(let response):
        debugPrint("/categories/get/{userId} API 연결 성공")
        debugPrint(response.statusCode)
        XCTAssertEqual(response.statusCode, 200, ErrorMessage.TellsWhatRightStatusCodeIs)
        debugPrint(response.request?.url as Any)

        do {
          let decodedData = try JSONDecoder().decode(
            [CategoryResponseDTO].self, from: response.data)
          debugPrint("/categoreis/get/{userId} API에서 가져온 데이터 디코딩 성공")
          debugPrint(decodedData)
        } catch (let error) {
          XCTFail("/categories/get/{userId} API에서 가져온 데이터 디코딩 실패 : \(error.localizedDescription)")
        }
      case .failure(let error):
        XCTFail("categories/get/{userId} API 연결 실패 : \(error.localizedDescription)")
      }
    }

    waitForExpectations(timeout: self.timeoutValue) { error in
      if let error = error {
        XCTFail("카테고리 조회 테스팅 간 에러 발생 : \(error.localizedDescription)")
      }
    }
  }

  // MARK: - 카테고리 제거

}
