//
//  ChartLabel.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import SwiftUI

public struct ChartLabel: View {
    public var lineChartViewModel: LineChartViewModel
    
    @Binding var indexPosition: Int
    
    public var body: some View {
        HStack {
            if let dates = lineChartViewModel.dates {
                let date = formatStringDate(dates[indexPosition])
                Text(date)
                    .opacity(0.5)
            }
            
            if let hours = lineChartViewModel.hours {
                let hour = hours[indexPosition]
                Text(hour)
                    .opacity(0.5)
            }
            
            Text("\(lineChartViewModel.prices[indexPosition], specifier: "%.2f")")
                .foregroundColor(lineChartViewModel.labelColor)
        }
    }

    public func formatStringDate(_ stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        let date = dateFormatter.date(from: stringDate)
        
        dateFormatter.dateStyle = .long
        let finalDate = dateFormatter.string(from: date!)
        
        return finalDate
    }
}
