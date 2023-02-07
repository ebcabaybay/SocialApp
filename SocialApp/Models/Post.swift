//
//  Post.swift
//  Yay!
//
//  Created by Spam C. on 2/7/23.
//

import Foundation

struct Post {
    let id: String
    var user: User
    var message: String?
    var imageUrl: URL?
    let timestamp: String
    
    init(documentId: String, data: [String: Any]) {
        let userId = data["userId"] as? String
        let displayName = data["displayName"] as? String
        let date = data["date"] as? String
        
        id = documentId
        user = User(id: userId ?? "", name: displayName ?? "", profileImageUrl: nil)
        message = data["message"] as? String
        timestamp = date ?? ""
        
        if let imageUrlString = data["imageUrl"] as? String {
            imageUrl = URL(string: imageUrlString)
        } else {
            imageUrl = nil
        }
    }
}
