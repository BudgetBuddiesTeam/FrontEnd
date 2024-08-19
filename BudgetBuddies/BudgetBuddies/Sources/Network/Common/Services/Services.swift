//
//  Services.swift
//  BudgetBuddies
//
//  Created by 이승진 on 8/12/24.
//

import Foundation

protocol ServiceType {
    var consumeGoalService: ConsumeGoalServiceType { get set }
}

class Services: ServiceType {
    var consumeGoalService: ConsumeGoalServiceType
    
    init() {
        self.consumeGoalService = ConsumeGoalService()
    }
}


