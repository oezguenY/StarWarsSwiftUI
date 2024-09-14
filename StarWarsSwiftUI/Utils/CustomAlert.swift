//
//  CustomSystemAlert.swift
//  StarWarsSwiftUI
//
//  Created by Özgün Yildiz on 14.09.24.
//

import Foundation
import SwiftUI

struct CustomSystemAlert {
    private static func errorDescription(_ error: Error) -> String {
        switch error {
        case ApiError.invalidUrl:
            return NSLocalizedString("alertDescriptionInvalidUrl", comment: "")
        case ApiError.invalidResponse:
            return NSLocalizedString("alertDescriptionInvalidResponse", comment: "")
        case ApiError.invalidData:
            return NSLocalizedString("alertDescriptionInvalidData", comment: "")
        default:
            return NSLocalizedString("alertDescriptionUnexpectedError", comment: "")
        }
    }
    
    func alertFromError(_ error: Error, shouldShowAlert: Binding<Bool>) -> Alert {
        let errorDescription = Self.errorDescription(error)
        let primaryButton: Alert.Button = .default(Text(localizedStringKey: "alertOkButton"),
                                                   action: {
            shouldShowAlert.wrappedValue = false
        })
        return Alert(title: Text(NSLocalizedString("alertErrorTitle", comment: "")),
                     message: Text(errorDescription),
                     dismissButton: primaryButton)
    }
}
