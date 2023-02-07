//
//  SignUpViewModel.swift
//  Yay!
//
//  Created by Spam C. on 2/8/23.
//

import Foundation

class SignUpViewModel {
    func signUp(fullName: String, email: String, password: String) {
        UserApiService.signUp(fullName: fullName, email: email, password: password).request()
    }
}
