//
//  ServerInfo.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/5/24.
//

import Foundation

enum ServerInfo {
  static let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASEURL") as! String
}
