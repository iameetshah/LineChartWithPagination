//
//  LineChartDataEntry.swift
//  LineChartWithPagination
//
//  Created by Mit Shah on 21/12/21.
//

import Foundation
import Charts
class LineChartDataEntry: ChartDataEntry {
    
    // MARK: - Initializers
    
    init(xValue: Double, yValue: Double) {
        super.init(x: xValue, y: yValue)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}
