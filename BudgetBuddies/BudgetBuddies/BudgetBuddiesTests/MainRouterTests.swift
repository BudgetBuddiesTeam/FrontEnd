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
  // MARK: - 메인페이지 요청 테스트

  func testGetMainPageData() {
    let expectation = self.expectation(description: "Server responds successfully")

    provider.request(.get(userId: self.userId)) { result in
      defer { expectation.fulfill() }
      switch result {
      case .success(let response):
        debugPrint("/main API 연결 성공")
        debugPrint(response.statusCode)
        XCTAssertEqual(response.statusCode, 200, ErrorMessage.TellsWhatRightStatusCodeIs)
        debugPrint(response.request?.url as Any)

        do {
          let decodedData = try JSONDecoder().decode(
            APIResponseMainPageResponseDto.self, from: response.data)
          debugPrint("/main API에서 가져온 데이터 디코딩 성공")
          debugPrint(decodedData)
        } catch (let error) {
          XCTFail("/main API에서 가져온 데이터 디코딩 실패 : \(error.localizedDescription)")
        }
      case .failure(let error):
        XCTFail("/main API 연결 실패 : \(error.localizedDescription)")
      }
    }

    waitForExpectations(timeout: self.timeoutValue) { error in
      if let error = error {
        XCTFail("메인페이지 요청 테스팅 간 에러 발생 : \(error.localizedDescription)")
      }
    }
  }
}
