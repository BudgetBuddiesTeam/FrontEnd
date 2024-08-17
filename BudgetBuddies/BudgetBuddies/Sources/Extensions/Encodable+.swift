//
//  Encodable+.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/17/24.
//

import Foundation

extension Encodable {
    
    /// 현재 Encodable객체를 Dictionary객체로 변환합니다.
    ///
    /// 이 매서드는 먼저 객체를 'JSONEncoder'를 사용해 JSON데이터로 인코딩한 다음,
    /// 이 JSON데이터를 'JSONSerialization'을 사용하여 '[String: Any]'형태의 Dictionary객체로 변환합니다.
    ///
    /// - Throws: - 객체 인코딩에 실패한 경우 'Encoding Error', JSON 데이터를 Dictionnary로 변환할 수 없는 경우 'NSError'
    ///
    /// - Returns: Dictionary 형태
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        return try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    }
}
