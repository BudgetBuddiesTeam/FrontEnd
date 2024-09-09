//
//  MainModel.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/25/24.
//

import Foundation
import Moya
import PromiseKit

/*
 # 코드 설계 의도
 - 모델 객체에서 사용하는 프로퍼티이자 실질적인 비즈니스 로직의 데이터를 Publisher로 설계
 - View의 UI 컴포넌트들에서 사용하는 데이터들이 모델 객체의 데이터를 Observe 하도록 설계
 */

class MainModel {

  // MARK: - Properties

  // Network Properties
  private let userProvider = MoyaProvider<UserRouter>()
  private let mainProvider = MoyaProvider<MainRouter>()

  // Combine Properties

  // Business Data Properties
  internal var userId: Int

  /*
   해야 할 일
   - DTO에서 가져온 데이터를 View 객체에 주입이 가능하도록 데이터를 재가공해서 사용하는 방법과 DTO 객체를 그대로 컨트롤러에서 사용하는 방법 중 효과적인 방법에 대해서 고민
   */
  internal var apiResponseResponseUserData: ApiResponseResponseUserDto
  internal var apiResponseMainPageResponseData: ApiResponseMainPageResponseDto

  // MARK: - Initializer

  init(userId: Int) {
    self.userId = userId

    /*
     해야 할 일
     - 기본 데이터를 할당하는 과정은 개선할 수 있다.
     */
    self.apiResponseResponseUserData = ApiResponseResponseUserDto(
      isSuccess: false,
      code: "",
      message: "",
      result: ResponseUserDto(
        id: 1,
        phoneNumber: "",
        name: "",
        email: "",
        age: 0,
        gender: "",
        photoURL: "",
        consumptionPattern: "",
        lastLoginAt: ""))

    /*
     해야 할 일
     - 기본 데이터를 할당하는 과정은 개선할 수 있다.
     - 기본 데이터를 추상화 해야 함.
     */
    self.apiResponseMainPageResponseData = ApiResponseMainPageResponseDto(
      isSuccess: false,
      code: "",
      message: "",
      result: MainPageResponseDto(
        consumptionAnalysisResponseDto: ConsumptionAnalysisResponseDto(
          goalCategory: "",
          currentWeekConsumptionAmount: 0),
        consumptionGoalResponseListDto: ConsumptionGoalResponseListDto(
          goalMonth: "",
          totalGoalAmount: 0,
          totalConsumptionAmount: 0,
          consumptionGoalList: [
            ConsumptionGoalResponseDto(
              categoryName: "",
              categoryId: 0,
              goalAmount: 0,
              consumeAmount: 0),
            ConsumptionGoalResponseDto(
              categoryName: "",
              categoryId: 0,
              goalAmount: 0,
              consumeAmount: 0),
            ConsumptionGoalResponseDto(
              categoryName: "",
              categoryId: 0,
              goalAmount: 0,
              consumeAmount: 0),
            ConsumptionGoalResponseDto(
              categoryName: "",
              categoryId: 0,
              goalAmount: 0,
              consumeAmount: 0),

          ]),
        discountResponseDtoList: [
          DiscountResponseDto(
            id: 0,
            title: "",
            startDate: "2024-08-28",
            endDate: "2024-08-29",
            anonymousNumber: 0,
            discountRate: 0,
            likeCount: 0,
            siteUrl: "",
            thumbnailUrl: ""),
          DiscountResponseDto(
            id: 0,
            title: "",
            startDate: "2024-08-28",
            endDate: "2024-08-29",
            anonymousNumber: 0,
            discountRate: 0,
            likeCount: 0,
            siteUrl: "",
            thumbnailUrl: ""),
        ],
        supportResponseDtoList: [
          SupportResponseDto(
            id: 0,
            title: "",
            startDate: "2024-08-28",
            endDate: "2024-08-29",
            anonymousNumber: 0,
            likeCount: 0,
            siteUrl: "",
            thumbnailUrl: ""),
          SupportResponseDto(
            id: 0,
            title: "",
            startDate: "2024-08-28",
            endDate: "2024-08-29",
            anonymousNumber: 0,
            likeCount: 0,
            siteUrl: "",
            thumbnailUrl: ""),
        ]))

    self.reloadDataFromServer()
  }

  // MARK: - Methosd

  internal func reloadDataFromServer(completion: ((Swift.Result<Void, Error>) -> Void)? = nil) {
    firstly {
      when(fulfilled: self.fetchUserDataFromServer(), self.fetchMainDataFromServer())
    }.done { apiResponseResponseUserDto, apiResponseMainPageResponseDto in
      self.apiResponseResponseUserData = apiResponseResponseUserDto
      self.apiResponseMainPageResponseData = apiResponseMainPageResponseDto
      completion?(.success(()))
    }.catch { anyError in
      completion?(.failure(anyError))
    }
  }

  private func fetchUserDataFromServer() -> Promise<ApiResponseResponseUserDto> {
    return Promise { seal in
      userProvider.request(.find(userId: self.userId)) { result in
        switch result {
        case .success(let response):
          do {
            let decodedData = try JSONDecoder().decode(
              ApiResponseResponseUserDto.self, from: response.data)
            seal.fulfill(decodedData)
          } catch (let decodingError) {
            seal.reject(decodingError)
          }
        case .failure(let connectionError):
          seal.reject(connectionError)
        }
      }
    }
  }

  private func fetchMainDataFromServer() -> Promise<ApiResponseMainPageResponseDto> {
    return Promise { seal in
      mainProvider.request(.get(userId: self.userId)) { result in
        switch result {
        case .success(let response):
          do {
            let decodedData = try JSONDecoder().decode(
              ApiResponseMainPageResponseDto.self, from: response.data)
            seal.fulfill(decodedData)
          } catch (let decodingError) {
            seal.reject(decodingError)
          }
        case .failure(let connectionError):
          seal.reject(connectionError)
        }
      }
    }
  }
}
