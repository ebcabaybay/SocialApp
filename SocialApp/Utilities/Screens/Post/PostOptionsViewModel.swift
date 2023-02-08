//
//  PostOptionsViewModel.swift
//  Yay!
//
//  Created by Spam C. on 2/8/23.
//

import Foundation

class PostOptionsViewModel {
    var post: Post!
    
    func deletePost(completion: ((Bool) -> Void)?) {
        PostApiService.deletePost(post: post).request { [weak self] (result: Result<Bool>) in
            switch result {
                case .success(let success):
                    completion?(success)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
