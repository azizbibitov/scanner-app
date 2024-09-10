//
//  HeaderView.swift
//  ScannerApp
//
//  Created by Aziz Bibitov on 09.09.2024.
//

import SwiftUI

struct HeaderView: View {

    @EnvironmentObject var coordinator: Coordinator
    var title: String

    var body: some View {
        Text(LocalizedStringKey(title))
            .textStyle()
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 60)
            .font(.title2)
            .overlay(alignment: .leading) {
                Button {
                    coordinator.pop()
                } label: {
                    Image(systemName: "chevron.backward")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 12, height: 25)
                        .foregroundColor(.white)
                }.frame(width: 40, height: 40, alignment: .leading)
                    .padding(.horizontal, 16)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blueLightCustom, Color.blueDarkCustom]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }
}

#Preview {
    HeaderView(title: "Crop")
}
