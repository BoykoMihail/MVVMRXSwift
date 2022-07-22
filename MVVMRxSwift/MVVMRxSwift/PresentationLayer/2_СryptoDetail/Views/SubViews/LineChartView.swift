//
//  LineChartView.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import SwiftUI

public struct LineChartView: View {
    var lineChartViewModel: LineChartViewModel
    
    @State var showingIndicators = false
    @State var indexPosition = Int()
    
    public var body: some View {
        if lineChartViewModel.prices.isNullOrEmpty {} else {
            VStack {
                ChartLabel(lineChartViewModel: lineChartViewModel, indexPosition: $indexPosition)
                    .opacity(showingIndicators ? 1: 0)
                
                LineView(
                    lineChartViewModel: lineChartViewModel,
                    showingIndicators: $showingIndicators,
                    indexPosition: $indexPosition
                )
            }
        }
    }
}
