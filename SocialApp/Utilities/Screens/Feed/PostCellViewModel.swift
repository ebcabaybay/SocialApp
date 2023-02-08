//
//  PostCellViewModel.swift
//  Yay!
//
//  Created by Spam C. on 2/8/23.
//

import Foundation
import FirebaseStorage

class PostViewCellModel {
    var user: User!
    var post: Post!
    
    var isPostDeletable: Bool { user.id == post.user.id }
    var imageProfileUrl: URL? { post.user.profileImageUrl }
    var name: String? { post.user.name }
    var timestamp: String { post.timestamp }
    var message: String? { post.message }
    var imagePostRef: StorageReference? { post.imageRef }
}
