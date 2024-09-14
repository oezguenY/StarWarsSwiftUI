//
//  CustomTypo.swift
//  StarWarsSwiftUI
//
//  Created by Özgün Yildiz on 14.09.24.
//

import Foundation
import SwiftUI

struct CustomTypography {
    static var title: Font { CustomFont.starWars(size: 80) }
    static var subtitle: Font { CustomFont.starWars(size: 24) }
    static var h1: Font { CustomFont.starWars(size: 32) }
    static var body: Font { CustomFont.starWars(size: 16) }
    
    static func custom(size: CGFloat) -> Font {
        CustomFont.starWars(size: size)
    }
    
    private init() {}
}

struct CustomFont {
    static func starWars(size: CGFloat) -> Font {
        .custom("StarWars", size: size)
    }
}

extension Text {
    func titleStyle() -> some View {
        self
            .customStyle(color: CustomColor.starWarsYellow,
                         font: CustomTypography.title,
                         lineLimit: 2)
    }
    
    func subtitleStyle() -> some View {
        self
            .customStyle(color: CustomColor.starWarsYellow,
                         font: CustomTypography.subtitle,
                         lineLimit: 2)
    }
    
    func h1Style() -> some View {
        self
            .customStyle(color: CustomColor.starWarsYellow,
                         font: CustomTypography.h1)
    }
    
    func bodyStyle(color: Color = CustomColor.white) -> some View {
        self
            .customStyle()
    }
    
    func customStyleWithSize(color: Color = CustomColor.white,
                             size: CGFloat,
                             lineLimit: Int = 1) -> some View {
        customStyle(color: color,
                    font: CustomTypography.custom(size: size),
                    lineLimit: lineLimit)
    }
    
    private func customStyle(color: Color = CustomColor.white,
                             font: Font = CustomTypography.body,
                             lineLimit: Int = 1) -> some View {
        self
            .foregroundStyle(color)
            .font(font)
            .lineLimit(lineLimit)
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.7)
    }
}
