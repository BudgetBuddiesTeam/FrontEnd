//
//  MainRouterTests.swift
//  BudgetBuddiesTests
//
//  Created by Jiwoong CHOI on 8/16/24.
//

import Moya
import XCTest

@testable import BudgetBuddies

final class MainRouterTests: XCTestCase {
  var provider: MoyaProvider<MainRouter>!
  var userId: Int!
  var timeoutValue: Double!

  override func setUp() {
    super.setUp()

    provider = MoyaProvider<MainRouter>()
    userId = 1
    timeoutValue = 10.0
  }

  func testGetMainPageData() {
    let expectation = self.expectation(description: "Server responds successfully")

    provider.request(.get(userId: self.userId)) { result in
      defer { expectation.fulfill() }
      switch result {
      case .success(let response):
        debugPrint("/main API 연결 성공")
        debugPrint(response.statusCode)
        debugPrint(response.request?.url as Any)

        do {
          let decodedData = try JSONDecoder().decode(
            APIResponseMainPageResponseDto.self, from: response.data)
          debugPrint("/main API에서 가져온 데이터 디코딩 성공")
          debugPrint(decodedData)
        } catch (let error) {
          debugPrint("/main API에서 가져온 데이터 디코딩 실패")
          debugPrint(error.localizedDescription)
        }
      case .failure(let error):
        debugPrint("/main API 연결 실패")
        debugPrint(error.localizedDescription)
      }
    }

    waitForExpectations(timeout: self.timeoutValue) { error in
      if let error = error {
        debugPrint(error.localizedDescription)
      }
    }
  }
}
