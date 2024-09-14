//
//  LoadingView.swift
//  StarWarsSwiftUI
//
//  Created by Özgün Yildiz on 14.09.24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            CustomColor.black.opacity(0.8)
            ProgressView {
                Text(localizedStringKey: "loadingMessage")
                    .customStyleWithSize(size: 16,
                                         lineLimit: 2)
            }
            .padding(.horizontal, 32)
        }
        .ignoresSafeArea()
    }
}
