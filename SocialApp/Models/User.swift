//
//  User.swift
//  Yay!
//
//  Created by Spam C. on 2/7/23.
//

import Foundation

struct User: Hashable {
    let id: String
    let name: String?
    let profileImageUrl: URL?
    
    var firstName: String {
        return String(name?.split(separator: " ").first ?? "")
    }
}
