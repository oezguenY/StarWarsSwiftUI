//
//  SpaceView.swift
//  StarWarsSwiftUI
//
//  Created by Özgün Yildiz on 14.09.24.
//

import SwiftUI

struct SpaceBackgroundView: View {
    var body: some View {
        ZStack {
            CustomImaging.spaceBackground
                .opacity(0.9)
            LinearGradient(gradient: Gradient(colors: [CustomColor.clear,
                                                       CustomColor.black,
                                                       CustomColor.darkerGray]),
                           startPoint: .top,
                           endPoint: .bottom)
        }
    }
}

#Preview {
    SpaceBackgroundView()
}
