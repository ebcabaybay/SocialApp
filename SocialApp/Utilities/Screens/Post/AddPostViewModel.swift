//
//  AddPostViewModel.swift
//  Yay!
//
//  Created by Spam C. on 2/8/23.
//

import Foundation

class AddPostViewModel {
    var user: User!
    
    var firstName: String { user.firstName }
    var name: String? { user.name }
    var imageUserUrl: URL? { user.profileImageUrl }
    
    func addPost(message: String, postImageUrl: URL?, completion: (() -> Void)?) {
        MessageHandler.showLoading()
        var post = Post(documentId: "", data: [:])
        post.user = user
        post.message = message
        post.imageUrl = postImageUrl
        
        PostApiService.addPost(post: post).request { (result: Result<Bool>) in
            switch result {
                case .success(_):
                    completion?()
                case .failure(let error):
                    MessageHandler.hideLoading()
                    print(error)
            }
        }
    }
}
