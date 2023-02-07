//
//  PostApiService.swift
//  Yay!
//
//  Created by Spam C. on 2/7/23.
//

import Foundation
import FirebaseFirestore

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum PostApiService {
    case getPosts
    case addPost(post: Post)
    case deletePost(post: Post)
    
    func request<T: Any>(completion: @escaping (Result<T>) -> ())  {
        switch self {
            case .getPosts:
                let db = Firestore.firestore()
                db.collection("posts").order(by: "date", descending: true).getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                        completion(.failure(err))
                    } else {
                        var posts: [Post] = []
                        for document in querySnapshot!.documents {
                            print("\(document.documentID) => \(document.data())")
                            let data = document.data()
                            let post = Post(documentId: document.documentID, data: data)
                            posts.append(post)
                        }
                        completion(.success(posts as! T))
                    }
                }
            case .addPost(let post):
                return
            case .deletePost(let post):
                return
        }
    }
}
