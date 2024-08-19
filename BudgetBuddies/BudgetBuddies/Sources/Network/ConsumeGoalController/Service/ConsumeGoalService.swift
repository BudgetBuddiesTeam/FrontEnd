//
//  ConsumeGoalService.swift
//  BudgetBuddies
//
//  Created by 이승진 on 8/13/24.
//

import Foundation
import Moya

enum ConsumeGoalError: Error {
    case decodingError
    case networkingError
}

protocol ConsumeGoalServiceType {
    func getConsumeGoal(date: String, userId: Int, completion: @escaping (Result<GetConsumeGoalResponse, ConsumeGoalError>) -> Void)
    
    func getTopGoal(userId: Int, peerAgeStart: Int, peerAgeEnd: Int, peerGender: String, completion: @escaping (Result<GetTopGoalResponse, ConsumeGoalError>) -> Void)
    
    func getTopGoals(userId: Int, peerAgeStart: Int, peerAgeEnd: Int, peerGender: String, completion: @escaping (Result<GetTopGoalsResponse, ConsumeGoalError>) -> Void)
    
    func getTopConsumption(userId: Int, peerAgeStart: Int, peerAgeEnd: Int, peerGender: String, completion: @escaping (Result<GetTopConsumptionResponse, ConsumeGoalError>) -> Void)
    
    func getTopConsumptions(userId: Int, peerAgeStart: Int, peerAgeEnd: Int, peerGender: String, completion: @escaping (Result<GetTopConsumptionsResponse, ConsumeGoalError>) -> Void)
    
    func getTopUser(userId: Int, completion: @escaping (Result<GetTopUserResponse, ConsumeGoalError>) -> Void)
    
    func getPeerInfo(userId: Int, peerAgeStart: Int, peerAgeEnd: Int, peerGender: String,  completion: @escaping (Result<ConsumePeerInfoResponse, ConsumeGoalError>) -> Void)
}

class ConsumeGoalService: ConsumeGoalServiceType {
    
    private let jsonDecoder = JSONDecoder()
    
    let provider = MoyaProvider<ConsumeRouter>()
    let userId = 1
    
    private func handleResponse<T: Decodable>(_ result: Result<Response, MoyaError>, responseType: T.Type, completion: @escaping (Result<T, ConsumeGoalError>) -> Void) {
        switch result {
        case .success(let response):
            do {
                let decodedResponse = try self.jsonDecoder.decode(responseType, from: response.data)
                completion(.success(decodedResponse))
            } catch {
                print("Decoding Error: \(error)")
                completion(.failure(.decodingError))
            }
        case .failure(let error):
            print("Networking Error: \(error)")
            completion(.failure(.networkingError))
        }
    }
    
    func getConsumeGoal(date: String, userId: Int, completion: @escaping (Result<GetConsumeGoalResponse, ConsumeGoalError>) -> Void) {
        provider.request(.getConsumeGoal(date: date, userId: userId)) { result in
            self.handleResponse(result, responseType: GetConsumeGoalResponse.self, completion: completion)
        }
    }
    
    func getTopGoal(userId: Int, peerAgeStart: Int, peerAgeEnd: Int, peerGender: String, completion: @escaping (Result<GetTopGoalResponse, ConsumeGoalError>) -> Void) {
        provider.request(.getTopGoal(userId: userId, peerAgeStart: peerAgeStart, peerAgeEnd: peerAgeEnd, peerGender: peerGender)) { result in
            self.handleResponse(result, responseType: GetTopGoalResponse.self, completion: completion)
        }
    }
    
    func getTopGoals(userId: Int, peerAgeStart: Int, peerAgeEnd: Int, peerGender: String, completion: @escaping (Result<GetTopGoalsResponse, ConsumeGoalError>) -> Void) {
        provider.request(.getTopGoals(userId: userId, peerAgeStart: peerAgeStart, peerAgeEnd: peerAgeEnd, peerGender: peerGender)) { result in
            self.handleResponse(result, responseType: GetTopGoalsResponse.self, completion: completion)
        }
    }
    
    func getTopConsumption(userId: Int, peerAgeStart: Int, peerAgeEnd: Int, peerGender: String, completion: @escaping (Result<GetTopConsumptionResponse, ConsumeGoalError>) -> Void) {
        provider.request(.getTopConsumption(userId: userId, peerAgeStart: peerAgeStart, peerAgeEnd: peerAgeEnd, peerGender: peerGender)) { result in
            self.handleResponse(result, responseType: GetTopConsumptionResponse.self, completion: completion)
        }
    }
    
    func getTopConsumptions(userId: Int, peerAgeStart: Int, peerAgeEnd: Int, peerGender: String, completion: @escaping (Result<GetTopConsumptionsResponse, ConsumeGoalError>) -> Void) {
        provider.request(.getTopConsumptions(userId: userId, peerAgeStart: peerAgeStart, peerAgeEnd: peerAgeEnd, peerGender: peerGender)) { result in
            self.handleResponse(result, responseType: GetTopConsumptionsResponse.self, completion: completion)
        }
    }
    
    func getTopUser(userId: Int, completion: @escaping (Result<GetTopUserResponse, ConsumeGoalError>) -> Void) {
        provider.request(.getTopUser(userId: userId)) { result in
            self.handleResponse(result, responseType: GetTopUserResponse.self, completion: completion)
        }
    }
    
    func getPeerInfo(userId: Int, peerAgeStart: Int, peerAgeEnd: Int, peerGender: String, completion: @escaping (Result<ConsumePeerInfoResponse, ConsumeGoalError>) -> Void) {
        provider.request(.getPeerInfo(userId: userId, peerAgeStart: peerAgeStart, peerAgeEnd: peerAgeEnd, peerGender: peerGender)) { result in
            self.handleResponse(result, responseType: ConsumePeerInfoResponse.self, completion: completion)
        }
    }
}
