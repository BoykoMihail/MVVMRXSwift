//
//  LinePath.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import SwiftUI

public struct LinePath: Shape {
    public var data: [Double]
    public var (width, height): (CGFloat, CGFloat)
    
    @Binding var pathPoints: [CGPoint]
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        var pathPoints = [CGPoint]()
        
        let normalizedData = normalize(data)
        let widthBetweenDataPoints = Double(width) / Double(normalizedData.count - 1)  // Remove first point
        let initialPoint = normalizedData[0] * Double(height)
        var x: Double = 0
        
        path.move(to: CGPoint(x: x, y: initialPoint))
        for y in normalizedData {
            if normalizedData.firstIndex(of: y) != 0 {
                x += widthBetweenDataPoints
                let y = y * Double(height)
                path.addLine(to: CGPoint(x: x, y: y))
            }

            pathPoints.append(path.currentPoint ?? CGPoint(x: 0, y: 0))
        }
        
        DispatchQueue.main.async {
            self.pathPoints = pathPoints
        }
        
        return path
    }
    
    public func normalize(_ data: [Double]) -> [Double] {
        var normalData = [Double]()
        let min = data.min()!
        let max = data.max()!

        for value in data {
            let normal = (value - min) / (max - min)
            normalData.append(normal)
        }
        
        return normalData
    }
}
