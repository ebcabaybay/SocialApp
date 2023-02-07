//
//  AccountViewModel.swift
//  Yay!
//
//  Created by Spam C. on 2/8/23.
//

import Foundation

class AccountViewModel {
    var user: User!
    
    var imageProfileUrl: URL? { user.profileImageUrl }
    
    func logout() {
        UserApiService.signOut.request()
    }
}
