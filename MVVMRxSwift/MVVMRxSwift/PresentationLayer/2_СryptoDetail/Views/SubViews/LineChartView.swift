//
//  LineChartView.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import SwiftUI

public struct LineChartView: View {
    @ObservedObject var lineChartViewModel: LineChartViewModel
    
    @State var showingIndicators = false
    @State var indexPosition = Int()
    
    public var body: some View {
        if lineChartViewModel.prices.isNullOrEmpty {} else {
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

//public extension LineChartView {
//    class LineChartViewModel: ObservableObject {
//        @Published private(set) var timeSeriesResponse: TimeSeriesResponse?
//        
//        private let service: ICurrenciesService
//        
//        init(service: ICurrenciesService) {
//            self.service = service
//        }
//        
//        func loadCountries(name: String) {
//            Task {
//                timeSeriesResponse = try await service.fetchTimeSeries(by: name)
//            }
//            
//        }
//    }
//}
