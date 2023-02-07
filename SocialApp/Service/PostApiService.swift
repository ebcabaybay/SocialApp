//
//  PostApiService.swift
//  Yay!
//
//  Created by Spam C. on 2/7/23.
//

import Foundation

enum PostApiService {
    case getPosts
    case addPost(post: Post)
    case deletePost(post: Post)
    
    func request()  {
//        switch self {
//            case .signIn(let email, let password):
//                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
//                    if let error = error {
//                        MessageHandler.displayErrorMessage(error: error)
//                    }
//                }
//            case .signUp(let fullName, let email, let password):
//                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//                    if let error = error {
//                        MessageHandler.displayErrorMessage(error: error)
//                    } else {
//                        let changeRequest = authResult?.user.createProfileChangeRequest()
//                        changeRequest?.displayName = fullName
//                        changeRequest?.commitChanges()
//                    }
//                }
//            case .signOut:
//                do {
//                    try Auth.auth().signOut()
//                } catch {
//
//                }
//                return
//        }
    }
}
