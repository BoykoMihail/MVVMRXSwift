//
//  DetailView.swift
//  MVVMRxSwift
//
//  Created by m.a.boyko on 20.07.2022.
//

import Foundation
import SwiftUI

private extension String {
    static let alertTitle = "Something went wrong"
    static let alertMessage = "Please try again later"
}

struct DetailView: View {
    @StateObject var lineChartViewModel: LineChartViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        if lineChartViewModel.isLoading {
            ActivityIndicator(style: .large)
        } else {
            ScrollView {
                HeaderView(lineChartViewModel: lineChartViewModel)
                    .padding()
                LineChartView(lineChartViewModel: lineChartViewModel)
                    .frame(minHeight: 240, maxHeight: 360)
                    .padding(.trailing)
                CustomSection(title: "Tagline") {
                    HStack(spacing: 2) {
                        Text(lineChartViewModel.tagline ?? "")
                            .font(Font.subheadline)
                            .foregroundColor(Color(UIColor.darkGray.cgColor))
                        Spacer()
                    }
                    .padding([.leading, .trailing])
                }
                CustomSection(title: "Description") {
                    Text(lineChartViewModel.detail)
                        .padding([.leading, .trailing])
                }
                CustomSection(title: "Official Links") {
                    FooterView(lineChartViewModel: lineChartViewModel)
                }
                .padding(.bottom)
            }
            .alert(isPresented: $lineChartViewModel.isError) {
                Alert(title: Text(String.alertTitle),
                      message: Text(String.alertMessage),
                      dismissButton: .cancel(Text("Ok")) {
                          self.presentationMode.wrappedValue.dismiss()
                      })
            }
            .navigationTitle(lineChartViewModel.name ?? "")
        }
    }
}
