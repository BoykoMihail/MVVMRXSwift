//
//  LineChartViewModel.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import SwiftUI

@MainActor public class LineChartViewModel: ObservableObject {
    // MARK: - Private Property
    private let service: ICurrenciesService
    private let name: String?

    // MARK: - Property
    @Published private var timeSeriesResponse: TimeSeriesResponse?
    
    // MARK: - Style
    @Published public var labelColor: Color
    @Published public var indicatorPointColor: Color
    @Published public var showingIndicatorLineColor: Color
    @Published public var flatTrendLineColor: Color
    @Published public var uptrendLineColor: Color
    @Published public var downtrendLineColor: Color
    
    // MARK: - Interactions
    public var dragGesture = false
    
    public var prices: [Double]? {
        timeSeriesResponse?.timeSeries?.compactMap { Double($0.price) }
    }
    
    public var dates: [String]? {
        timeSeriesResponse?.timeSeries?.compactMap { $0.date }
    }
    
    public init(
        service: ICurrenciesService,
        name: String?,
        labelColor: Color = .blue,
        indicatorPointColor: Color = .blue,
        showingIndicatorLineColor: Color = .blue,
        flatTrendLineColor: Color = .purple,
        uptrendLineColor: Color = .green,
        downtrendLineColor: Color = .red,
        
        dragGesture: Bool = false
    ) {
        self.service = service
        self.name = name
        self.labelColor = labelColor
        self.indicatorPointColor = indicatorPointColor
        self.showingIndicatorLineColor = showingIndicatorLineColor
        self.flatTrendLineColor = flatTrendLineColor
        self.uptrendLineColor = uptrendLineColor
        self.downtrendLineColor = downtrendLineColor
        
        self.dragGesture = dragGesture
        
        Task {

            if let name = name {
                timeSeriesResponse = try await service.fetchTimeSeries(by: name)
                debugPrint("BBoyko data = ", timeSeriesResponse?.timeSeries?.count ?? "not")
            }
        }
    }
}
