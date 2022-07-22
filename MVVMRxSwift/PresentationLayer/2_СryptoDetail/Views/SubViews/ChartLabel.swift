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
        if let prices = lineChartViewModel.prices {
            Text("\(prices[indexPosition])")
                .foregroundColor(.black)
        }
    }
}
