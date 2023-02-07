//
//  UserApiService.swift
//  Yay!
//
//  Created by Spam C. on 2/7/23.
//

import Foundation
import FirebaseAuth

enum UserApiService {
    case signIn(email: String, password: String)
    case signUp(fullName: String, email: String, password: String)
    case signOut
    
    func request()  {
        switch self {
            case .signIn(let email, let password):
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        MessageHandler.displayErrorMessage(error: error)
                    }
                }
            case .signUp(let fullName, let email, let password):
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        MessageHandler.displayErrorMessage(error: error)
                    } else {
                        MessageHandler.showLoading()
                        UserApiService.signOut.request()
                        let changeRequest = authResult?.user.createProfileChangeRequest()
                        changeRequest?.displayName = fullName
                        changeRequest?.commitChanges(completion: { error in
                            UserApiService.signIn(email: email, password: password).request()
                        })
                    }
                }
            case .signOut:
                do {
                    try Auth.auth().signOut()
                } catch {
                    
                }
        }
    }
}



