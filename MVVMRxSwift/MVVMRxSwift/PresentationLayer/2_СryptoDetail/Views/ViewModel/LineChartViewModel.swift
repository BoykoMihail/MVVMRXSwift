//
//  LineChartViewModel.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import SwiftUI

public class LineChartViewModel: ObservableObject {
    // MARK: Dependency

    private let service: ICurrenciesService
    
    // MARK: - Private Property
    
    private let token: String?

    // MARK: - Property
    @Published private var timeSeriesResponse: TimeSeriesResponse?
    @Published private var officialLinks: [OfficialLinks]?
    @Published private var _detail: String?
    
    // MARK: - Style
    
    @Published public var labelColor: Color
    @Published public var indicatorPointColor: Color
    @Published public var showingIndicatorLineColor: Color
    @Published public var flatTrendLineColor: Color
    @Published public var uptrendLineColor: Color
    @Published public var downtrendLineColor: Color
    @Published var image: UIImage?
    @Published var tagline: String?
    
    // MARK: - Calculated Properties
    
    public var prices: [Double]? {
        timeSeriesResponse?.timeSeries?.compactMap { Double($0.price) }
    }
    
    public var dates: [String]? {
        timeSeriesResponse?.timeSeries?.compactMap { $0.date }
    }
    
    public var urlDictionary: [String: String]? {
        officialLinks?.reduce(into: [String: String]()) {
            $0[$1.name] = $1.link
        }
    }
    
    public var detail: AttributedString {
        if let data = _detail?.data(using: .unicode),
           let nsAttrString = try? NSAttributedString(data: data,
                                                      options: [.documentType: NSAttributedString.DocumentType.html],
                                                      documentAttributes: nil) {
            return AttributedString(nsAttrString)
        }
        
        return AttributedString("")
    }
    
    // MARK: - Interactions
    
//    public var dragGesture = false
    public var isLoading = false
    public let name: String?
    public let price: String?

    public init(
        service: ICurrenciesService,
        token: String?,
        name: String?,
        price: String?,
        labelColor: Color = .blue,
        indicatorPointColor: Color = .blue,
        showingIndicatorLineColor: Color = .blue,
        flatTrendLineColor: Color = .purple,
        uptrendLineColor: Color = .green,
        downtrendLineColor: Color = .red
        
//        dragGesture: Bool = false
    ) {
        self.service = service
        self.name = name
        self.token = token
        self.labelColor = labelColor
        self.indicatorPointColor = indicatorPointColor
        self.showingIndicatorLineColor = showingIndicatorLineColor
        self.flatTrendLineColor = flatTrendLineColor
        self.uptrendLineColor = uptrendLineColor
        self.downtrendLineColor = downtrendLineColor
        self.price = price?.roundIfDouble(to: 2)
//        self.dragGesture = dragGesture
        isLoading = true
        Task {
            if let token = token {
                do {
                    async let asyncImage = ImageLoader(cache: ImageCache()).image(from: token)
                    async let asyncTimeSeriesResponse = service.fetchTimeSeries(by: token)
                    async let profile = service.fetchProfile(by: token)

                    _detail = try await profile.details
                    tagline = try await profile.tagline
                    officialLinks = try await profile.officialLinks
                    
                    if let strongAsyncImage = try await asyncImage {
                        image = strongAsyncImage
                    } else {
                        image = nil
                    }
                    
                    timeSeriesResponse = try await asyncTimeSeriesResponse
                    isLoading = false
                } catch {
                    //BBoyko
                    isLoading = false
                }
            }
        }
    }
}
