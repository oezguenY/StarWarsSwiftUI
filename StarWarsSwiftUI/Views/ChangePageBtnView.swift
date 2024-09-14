//
//  ChangePageBTN.swift
//  StarWarsSwiftUI
//
//  Created by Özgün Yildiz on 14.09.24.
//

import SwiftUI

enum PointingDirection: String {
    case left
    case right
}

struct ChangePageButtonView: View {
    let pointingDirection: PointingDirection
    let isDisabled: Bool
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "arrowtriangle.\(pointingDirection).fill")
                .foregroundColor(CustomColor.white)
                .opacity(isDisabled ? 0.3 : 1.0)
        }
        .disabled(isDisabled)
    }
}
