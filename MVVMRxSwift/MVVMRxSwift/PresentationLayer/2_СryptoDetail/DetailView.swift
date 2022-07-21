//
//  DetailView.swift
//  MVVMRxSwift
//
//  Created by m.a.boyko on 20.07.2022.
//

import Foundation
import SwiftUI

struct ContactPickerView: View {
    var body: some View {
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
        Spacer()
    }
}
