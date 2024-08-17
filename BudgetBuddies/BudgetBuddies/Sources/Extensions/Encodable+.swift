//
//  Encodable+.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/17/24.
//

import Foundation

extension Encodable {
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        return try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    }
}
