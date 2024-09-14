//
//  CustomColor.swift
//  StarWarsSwiftUI
//
//  Created by Özgün Yildiz on 14.09.24.
//

import Foundation
import SwiftUI

struct CustomColor {
    static var clear: Color { .clear }
    static var black: Color { Color.black }
    static var darkerGray: Color { Color("DarkerGray") }
    static var gray: Color { .gray }
    static var starWarsYellow: Color { Color("StarWarsYellow") }
    static var white: Color { .white }
    
    private init() {}
}
