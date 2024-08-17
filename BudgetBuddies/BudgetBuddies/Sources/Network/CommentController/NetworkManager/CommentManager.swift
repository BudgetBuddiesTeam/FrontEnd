//
//  CommentManager.swift
//  BudgetBuddies
//
//  Created by 김승원 on 8/17/24.
//

import Foundation
import Moya

final class CommentManager {
    static let shared = CommentManager()
    private init() {}
    
    let CommentProvider = MoyaProvider<CommentRouter>()
}
