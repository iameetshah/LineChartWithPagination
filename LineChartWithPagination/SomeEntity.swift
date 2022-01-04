//
//  SomeEntity.swift
//  LineChartWithPagination
//
//  Created by Mit Shah on 21/12/21.
//

import Foundation
class SomeEntity {
    
    let count: Int
    let amount: Double
    let isPrevious:Bool
    
    init(count: Int, amount: Double = 0.0, isPrevious:Bool = false) {
        
        self.count = count
        self.amount = amount
        self.isPrevious = isPrevious
    }
}
