//
//  LoginViewModel.swift
//  Yay!
//
//  Created by Spam C. on 2/8/23.
//

import Foundation

class LoginViewModel {
    func signIn(email: String, password: String) {
        UserApiService.signIn(email: email, password: password).request()
    }
}
