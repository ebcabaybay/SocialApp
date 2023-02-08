//
//  FeedViewModel.swift
//  Yay!
//
//  Created by Spam C. on 2/8/23.
//

import Foundation

class FeedViewModel {
    var user: User!
    var posts = Observable<[Post]>(value: [])
    var users: [User] {
        var users = Array(Set(posts.value.map { $0.user }))
        users.removeAll { $0.id == user.id }
        return [user] + users
    }
    
    func getPosts() {
        PostApiService.getPosts.request { [weak self] (result: Result<[Post]>) in
            switch result {
                case .success(let posts):
                    self?.posts.value = posts
                case .failure(let error):
                    print(error)
            }
        }
    }
}
