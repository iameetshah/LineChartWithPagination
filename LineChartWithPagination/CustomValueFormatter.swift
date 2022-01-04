//
//  CustomValueFormatter.swift
//  LineChartWithPagination
//
//  Created by Mit Shah on 21/12/21.
//

import Foundation
import Charts

class CustomValueFormatter: NSObject, IAxisValueFormatter {
    
    private let interval:Int!
    private let currency:String!
    
    init(interval:Int, currency:String) {
        self.interval = interval
        self.currency = currency
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let values = Int(value)
        guard let currencyValue = currency, values >= 0 else {
            return ""
        }
        
        if values == 0 {
            return "0 \(currencyValue)"
        }
        else if (values % 3) == 0 { // Update as per your requirement
            let value = values * interval
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
            formatter.roundingMode = .halfUp
            formatter.locale = Locale(identifier: Locale.current.identifier)
            formatter.multiplier = 1.0
            let formattedValue = formatter.string(for: value)!
            return "\(formattedValue) \(currencyValue)"
        }
        else {
            return ""
        }
    }
}
