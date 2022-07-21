//
//  LineChartView.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import SwiftUI

public struct LineChartView: View {
    public var lineChartViewModel: LineChartViewModel
    
    @State var showingIndicators = false
    @State var indexPosition = Int()
    
    public init(lineChartViewModel: LineChartViewModel) {
        self.lineChartViewModel = lineChartViewModel
    }
    
    public var body: some View {
        if lineChartViewModel.prices.isEmpty {} else {
            VStack {
                if lineChartViewModel.dragGesture {
                    ChartLabel(lineChartViewModel: lineChartViewModel, indexPosition: $indexPosition)
                        .opacity(showingIndicators ? 1: 0)
                }
                
                LineView(
                    lineChartViewModel: lineChartViewModel,
                    showingIndicators: $showingIndicators,
                    indexPosition: $indexPosition
                )
            }
        }
    }
}
