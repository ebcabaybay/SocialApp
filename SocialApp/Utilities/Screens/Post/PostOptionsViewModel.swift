//
//  PostOptionsViewModel.swift
//  Yay!
//
//  Created by Spam C. on 2/8/23.
//

import Foundation

class PostOptionsViewModel {
    var post: Post!
    
    func deletePost(completion: (() -> Void)?) {
        PostApiService.deletePost(post: post).request { [weak self] (result: Result<Bool>) in
            switch result {
                case .success(_):
                    completion?()
                case .failure(let error):
                    print(error)
            }
        }
    }
}
