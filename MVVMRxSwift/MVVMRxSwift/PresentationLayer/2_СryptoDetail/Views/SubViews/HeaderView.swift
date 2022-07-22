//
//  HeaderView.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    @ObservedObject var lineChartViewModel: LineChartViewModel
    
    var body: some View {
        HStack {
            if let image = lineChartViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 64.0, height: 64.0, alignment: .leading)
            }
            Spacer()
            if let price = lineChartViewModel.price {
                Spacer()
                Text(price)
                    .font(.title)
                    .bold()
            }
        }
    }
}
