//
//  TextExtension.swift
//  StarWarsSwiftUI
//
//  Created by Özgün Yildiz on 14.09.24.
//

import Foundation
import SwiftUI

extension Text {
    init(localizedStringKey: String, argument: String? = nil) {
        var localizedString: String
        
        if let argument = argument {
            localizedString = String.localizedStringWithFormat(NSLocalizedString(localizedStringKey, comment: ""),
                                                               argument)
        } else {
            localizedString = NSLocalizedString(localizedStringKey, comment: "")
            
        }
        self.init(localizedString)
    }
}
