//
//  CustomSection.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 22.07.2022.
//

import SwiftUI

struct CustomSection<Content: View>: View {
    var content: () -> Content
    let title: String
    
    init(title: String, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.title = title
    }

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(title)
                    .font(.title2)
                    .foregroundColor(Color(UIColor.darkGray.cgColor))
                    .bold()
                Spacer()
            }
            .padding([.top, .leading, .trailing])
            content()
        }
    }
}
