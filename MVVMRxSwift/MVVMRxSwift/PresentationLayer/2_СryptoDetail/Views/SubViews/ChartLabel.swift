//
//  ChartLabel.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import SwiftUI

public struct ChartLabel: View {
    @StateObject public var lineChartViewModel: LineChartViewModel
    
    @Binding var indexPosition: Int
    
    public var body: some View {
        HStack {
            if let dates = lineChartViewModel.dates {
                let date = formatStringDate(dates[indexPosition])
                Text(date)
                    .opacity(0.5)
            }
            if let prices = lineChartViewModel.prices {
                Text("\(prices[indexPosition])")
                    .foregroundColor(lineChartViewModel.labelColor)
            }
        }
    }

    public func formatStringDate(_ timeSeries: String) -> String {
        if let dateInMillisecond = Int64(timeSeries) {
            let date = Date(milliseconds: dateInMillisecond)

            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            let finalDate = dateFormatter.string(from: date)

            return finalDate
        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yy-MM-dd"
//        let date = dateFormatter.date(from: stringDate)
//
//        dateFormatter.dateStyle = .long
//        let finalDate = dateFormatter.string(from: date!)
        
        return "finalDate"
    }
}

extension Date {
    var millisecondsSince1970:Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
