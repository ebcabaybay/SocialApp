//
//  MessageHandler.swift
//  Yay!
//
//  Created by Spam C. on 2/7/23.
//

import Foundation
import SwiftMessages

class MessageHandler {
    static func displayErrorMessage(error: Error) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.configureContent(title: "Error", body: error.localizedDescription)
        view.button?.isHidden = true
        SwiftMessages.show(view: view)
    }
    
    static func displaySuccessMessage(message: String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.success)
        view.configureContent(title: "Success", body: message)
        view.button?.isHidden = true
        SwiftMessages.show(view: view)
    }
}
