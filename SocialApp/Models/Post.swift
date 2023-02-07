//
//  Post.swift
//  Yay!
//
//  Created by Spam C. on 2/7/23.
//

import Foundation

struct Post {
    let id: String
    let user: User
    let message: String?
    let imageUrl: String?
    let timestamp: String
    
    init(documentId: String, data: [String: Any]) {
        let userId = data["userId"] as? String
        let displayName = data["displayName"] as? String
        let date = data["date"] as? String
        
        id = documentId
        user = User(id: userId ?? "", name: displayName ?? "", profileImageUrl: nil)
        message = data["message"] as? String
        imageUrl = data["imageUrl"] as? String
        timestamp = date ?? ""
    }
}
