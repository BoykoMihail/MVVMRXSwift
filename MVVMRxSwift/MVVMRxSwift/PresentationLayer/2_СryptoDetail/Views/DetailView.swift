//
//  DetailView.swift
//  MVVMRxSwift
//
//  Created by m.a.boyko on 20.07.2022.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @ObservedObject var lineChartViewModel: LineChartViewModel
    
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
                Spacer()
                VStack(spacing: 8) {
                    HStack(spacing: 2) {
                        Text("Tagline")
                            .font(.title2)
                            .foregroundColor(Color(UIColor.darkGray.cgColor))
                            .bold()
                        Spacer()
                    }
                    HStack(spacing: 2) {
                        Text(lineChartViewModel.tagline ?? "")
                            .font(Font.subheadline)
                            .foregroundColor(Color(UIColor.darkGray.cgColor))
                        Spacer()
                    }
                }
                .padding([.leading, .trailing, .top])
                if let data = lineChartViewModel.detail {
                    VStack(spacing: 8) {
                        HStack {
                            Text("Description")
                                .font(.title2)
                                .foregroundColor(Color(UIColor.darkGray.cgColor))
                                .bold()
                            Spacer()
                        }
                        .padding([.top, .leading, .trailing])
                        Text(data)
                            .padding([.leading, .trailing])
                    }
                }
                VStack(spacing: 8) {
                    HStack {
                        Text("Official Links")
                            .font(.title2)
                            .foregroundColor(Color(UIColor.darkGray.cgColor))
                            .bold()
                        Spacer()
                    }
                    .padding([.leading, .trailing, .top])
                    FooterView(lineChartViewModel: lineChartViewModel)
                }
                .padding(.bottom)
            }
            .navigationTitle(lineChartViewModel.name ?? "")
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {

    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}
