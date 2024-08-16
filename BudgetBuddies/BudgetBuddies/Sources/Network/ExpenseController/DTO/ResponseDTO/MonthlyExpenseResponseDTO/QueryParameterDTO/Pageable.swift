//
//  Pageable.swift
//  BudgetBuddies
//
//  Created by Jiwoong CHOI on 8/16/24.
//

import Foundation

struct Pageable: Codable {
  /// 월별 소비 기록 데이터를 나누는 페이지
  let page: Int

  /// 월별 소비 기록 데이터 개수
  let size: Int
}
