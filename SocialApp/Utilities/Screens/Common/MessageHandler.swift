//
//  MessageHandler.swift
//  Yay!
//
//  Created by Spam C. on 2/7/23.
//

import Foundation
import SwiftMessages
import Kingfisher

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
    
    static func showLoading() {
        let view = MessageView.viewFromNib(layout: .centeredView)
        view.configureTheme(.info)
        view.configureDropShadow()
        view.backgroundHeight = 250
        view.backgroundView?.backgroundColor = UIColor.white
        view.configureContent(title: "Loading...", body: "")
        guard let url = Bundle.main.url(forResource: "loading", withExtension: "gif") else { return }
        view.iconImageView?.kf.setImage(with: url)
        view.button?.isHidden = true
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .center
        config.duration = .forever
        config.dimMode = .blur(style: .dark, alpha: 1, interactive: false)
        SwiftMessages.show(config: config, view: view)
    }
    
    static func hideLoading() {
        SwiftMessages.hideAll()
    }
}
