//
//  Post.swift
//  Yay!
//
//  Created by Spam C. on 2/7/23.
//

import Foundation
import FirebaseStorage

struct Post {
    var id: String
    var user: User
    var message: String?
    var imageUrl: URL?
    var timestamp: String
    var imageRef: StorageReference? {
        if let imageUrl = imageUrl {
            let storage = Storage.storage()
            let storageRef = storage.reference()
            return storageRef.child(imageUrl.absoluteString)
        }
        return nil
    }
}

extension Post {
    init(documentId: String, data: [String: Any]) {
        let userId = data["userId"] as? String
        let displayName = data["displayName"] as? String
        let date = data["date"] as? String
        let profileImageUrl = data["profileImageUrl"] as? String
        
        id = documentId
        user = User(id: userId ?? "", name: displayName ?? "", profileImageUrl: URL(string: profileImageUrl ?? ""))
        message = data["message"] as? String
        timestamp = date ?? ""
        
        if let imageUrlString = data["imageUrl"] as? String {
            imageUrl = URL(string: imageUrlString)
        } else {
            imageUrl = nil
        }
    }
}
