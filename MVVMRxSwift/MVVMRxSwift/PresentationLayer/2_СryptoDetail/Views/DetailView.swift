//
//  DetailView.swift
//  MVVMRxSwift
//
//  Created by m.a.boyko on 20.07.2022.
//

import Foundation
import SwiftUI

struct ContactPickerView: View {
    private let lineChartViewModel: LineChartViewModel
    
    init(lineChartViewModel: LineChartViewModel) {
        self.lineChartViewModel = lineChartViewModel
    }
    
    
    var body: some View {
        ScrollView {
            HStack {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .resizable()
                    .frame(width: 54.0, height: 54.0, alignment: .leading)
                Spacer()
                VStack {
                    Text("Bitcoin")
                    Text("Coommon! Buy Me!")
                }
                Spacer()
                Text("12345")
                    .multilineTextAlignment(.trailing)
            }
            .padding()
            LineChartView(lineChartViewModel: lineChartViewModel).frame(minHeight: 240, maxHeight: 360)
            Spacer()
            // swiftlint:disable line_length
            Text("Bitcoin is the first successfully distributed consensus-based, censorship-resistant, peer-to-peer payment settlement network with a provably scarce, programmable, native currency. Bitcoin is the first successfully distributed consensus-based, censorship-resistant, peer-to-peer payment settlement network with a provably scarce, programmable, native currency.Bitcoin is the first successfully distributed consensus-based, censorship-resistant, peer-to-peer payment settlement network with a provably scarce, programmable, native currency.Bitcoin is the first successfully distributed consensus-based, censorship-resistant, peer-to-peer payment settlement network with a provably scarce, programmable, native currency.Bitcoin is the first successfully distributed consensus-based, censorship-resistant, peer-to-peer payment settlement network with a provably scarce, programmable, native currency.Bitcoin is the first successfully distributed consensus-based, censorship-resistant, peer-to-peer payment settlement network with a provably scarce, programmable, native currency.Bitcoin is the first successfully distributed consensus-based, censorship-resistant, peer-to-peer payment settlement network with a provably scarce, programmable, native currency.Bitcoin is the first successfully distributed consensus-based, censorship-resistant, peer-to-peer payment settlement network with a provably scarce, programmable, native currency.Bitcoin is the first successfully distributed consensus-based, censorship-resistant, peer-to-peer payment settlement network with a provably scarce, programmable, native currency.Bitcoin is the first successfully distributed consensus-based, censorship-resistant, peer-to-peer payment settlement network with a provably scarce, programmable, native currency.")
            // swiftlint:enable line_length
            Spacer()
            Text("[Privacy Policy](https://example.com)").frame(alignment: .leading)
            Spacer()
        }
    }
}
