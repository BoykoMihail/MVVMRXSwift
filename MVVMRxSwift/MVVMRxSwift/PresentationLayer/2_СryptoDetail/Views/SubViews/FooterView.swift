//
//  FooterView.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import Foundation
import SwiftUI

struct FooterView: View {
    @ObservedObject var lineChartViewModel: LineChartViewModel
    
    var body: some View {
        if let dict = lineChartViewModel.urlDictionary {
            let keys = dict.map { $0.key }
            let values = dict.map { $0.value }
            let count = dict.count
            ForEach(0..<count) { index in
                HStack {
                    Text(.init("\(index + 1)."))
                        .font(Font.footnote)
                    Text(.init("[\(keys[index])](\(values[index]))"))
                        .font(Font.body)
                    Spacer()
                }
                .padding([.trailing, .leading])
            }
        }
    }
}
