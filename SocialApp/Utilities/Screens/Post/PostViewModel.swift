//
//  PostViewModel.swift
//  Yay!
//
//  Created by Spam C. on 2/8/23.
//

import Foundation
import FirebaseStorage

class PostViewModel {
    var post: Post!
    
    var name: String? { post.user.name }
    var timestamp: String { post.timestamp }
    var message: String? { post.message }
    var imagePostRef: StorageReference? { post.imageRef }
    var imageUserUrl: URL? { post.user.profileImageUrl }
    
}
