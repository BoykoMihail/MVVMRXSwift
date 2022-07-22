//
//  LineView.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import SwiftUI

public typealias ClosestValue = (CGFloat, CGFloat, Int)

public struct LineView: View {
    public var lineChartViewModel: LineChartViewModel
    
    @Binding var showingIndicators: Bool
    @Binding var indexPosition: Int
    @State var indicatorPointPosition: CGPoint = .zero
    @State var pathPoints = [CGPoint]()
    
    public var body: some View {
        ZStack {
            if let prices = lineChartViewModel.prices {
                GeometryReader { proxy in
                    LinePath(data: prices, width: proxy.size.width, height: proxy.size.height, pathPoints: $pathPoints)
                        .stroke(lineChartViewModel.colorLine(), lineWidth: 2)
                }
            }
            
            if showingIndicators {
                IndicatorPoint(lineChartViewModel: lineChartViewModel)
                    .position(x: indicatorPointPosition.x, y: indicatorPointPosition.y)
            }
        }
        .rotationEffect(.degrees(180), anchor: .center)
        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
        .contentShape(Rectangle())
        .gesture(
            LongPressGesture(minimumDuration: 0.1)
                .sequenced(before: DragGesture(minimumDistance: 0, coordinateSpace: .local))
                .onChanged({ value in
                    switch value {
                    case .second(true, let drag):
                        if let longPressLocation = drag?.location {
                            dragGesture(longPressLocation)
                        }
                    default:
                        break
                    }
                })
                .onEnded { _ in
                    self.showingIndicators = false
                }
        )
    }
    
    public struct IndicatorPoint: View {
        public var lineChartViewModel: LineChartViewModel
        
        public var body: some View {
            Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(lineChartViewModel.colorLine())
        }
    }
    
    public func dragGesture(_ longPressLocation: CGPoint) {
        guard let (closestXPoint, closestYPoint, yPointIndex) = getClosestValueFrom(longPressLocation,
                                                                                    inData: pathPoints) else {
            return
        }
        self.indicatorPointPosition.x = closestXPoint
        self.indicatorPointPosition.y = closestYPoint
        self.showingIndicators = true
        self.indexPosition = yPointIndex
    }
    
    public func getClosestValueFrom(_ value: CGPoint, inData: [CGPoint]) -> ClosestValue? {
        let touchPoint: (CGFloat, CGFloat) = (value.x, value.y)
        let xPathPoints = inData.map { $0.x }
        let yPathPoints = inData.map { $0.y }
        
        guard let closestXPoint = xPathPoints
            .enumerated()
            .min( by: {
                abs($0.1 - touchPoint.0) < abs($1.1 - touchPoint.0)
            }) else {
            return nil
        }
        
        let closestYPointIndex = xPathPoints.firstIndex(of: closestXPoint.element)!
        let closestYPoint = yPathPoints[closestYPointIndex]
        
        let yPointIndex = yPathPoints.firstIndex(of: closestYPoint)!

        return (closestXPoint.element, closestYPoint, yPointIndex)
    }
}
