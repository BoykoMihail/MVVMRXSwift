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
    @Published private var _timeSeriesResponse: TimeSeriesResponse?
    @Published private var _officialLinks: [OfficialLinks]?
    @Published private var _detail: String?
    
    // MARK: - Public Property
    
    @Published var tagline: String?
    @Published var image: UIImage?
    @Published var isError = false

    // MARK: - Style
    
    @Published var flatTrendLineColor: Color
    @Published var uptrendLineColor: Color
    @Published var downtrendLineColor: Color
    
    // MARK: - Calculated Properties
    
    public var prices: [Double]? {
        _timeSeriesResponse?.timeSeries?.compactMap { Double($0.price) }
    }
    
    public var urlDictionary: [String: String]? {
        _officialLinks?.reduce(into: [String: String]()) {
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
    
    public var isLoading = false
    public let name: String?
    public let price: String?

    public init(service: ICurrenciesService,
                token: String?,
                name: String?,
                price: String?,
                flatTrendLineColor: Color = .purple,
                uptrendLineColor: Color = .green,
                downtrendLineColor: Color = .red) {
        self.service = service
        self.name = name
        self.token = token
        self.flatTrendLineColor = flatTrendLineColor
        self.uptrendLineColor = uptrendLineColor
        self.downtrendLineColor = downtrendLineColor
        self.price = price

        isLoading = true
        Task {
            if let token = token {
                do {
                    async let asyncImage = ImageLoader(cache: ImageCache()).image(from: token)
                    async let asyncTimeSeriesResponse = service.fetchTimeSeries(by: token)
                    async let profile = service.fetchProfile(by: token)

                    await updateFields(details: try await profile.details,
                                       newTagline: try await profile.tagline,
                                       officialLinks: try await profile.officialLinks,
                                       newImage: try await asyncImage,
                                       timeSeriesResponse: try await asyncTimeSeriesResponse)
                    isLoading = false
                    self.isError = false
                } catch {
                    DispatchQueue.main.async {
                        self.isError = true
                    }
                    isLoading = false
                }
            }
        }
    }
    
    public func colorLine() -> Color {
        var color = uptrendLineColor
        
        guard let prices = prices else {
            return color
        }
        
        if prices.first! > prices.last! {
            color = downtrendLineColor
        } else if prices.first! == prices.last! {
            color = flatTrendLineColor
        }
        
        return color
    }
    
    @MainActor private func updateFields(details: String? = nil,
                                         newTagline: String? = nil,
                                         officialLinks: [OfficialLinks]? = nil,
                                         newImage: UIImage? = nil,
                                         timeSeriesResponse: TimeSeriesResponse? = nil) {
        _detail = details
        tagline = newTagline
        _officialLinks = officialLinks
        
        if let newImage = newImage {
            image = newImage
        } else {
            image = nil
        }

        _timeSeriesResponse = timeSeriesResponse
    }
}
