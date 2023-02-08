//
//  PostApiService.swift
//  Yay!
//
//  Created by Spam C. on 2/7/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

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
                let db = Firestore.firestore()
                var ref: DocumentReference? = nil
                ref = db.collection("posts").addDocument(data: [
                    "message": post.message,
                    "imageUrl": nil,
                    "userId": post.user.id,
                    "displayName": post.user.name,
                    "date": Date()
                ]) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                        if let postImageUrl = post.imageUrl {
                            let storage = Storage.storage()
                            let storageRef = storage.reference()
                            let imageUrl = "images/" + ref!.documentID + postImageUrl.lastPathComponent
                            let imagesRef = storageRef.child(imageUrl)
                            
                            let uploadTask = imagesRef.putFile(from: postImageUrl, metadata: nil) { metadata, error in
                                if let error = error {
                                    completion(.failure(error))
                                } else {
                                    db.collection("posts").document(ref!.documentID).updateData([
                                    "imageUrl": imageUrl,
                                    ]) { error in
                                        if let error = error {
                                            print("Error updating document: \(error)")
                                            completion(.failure(error))
                                        } else {
                                            print("Document successfully updated")
                                            completion(.success(true as! T))
                                        }
                                    }
                                }
                            }
                        } else {
                            completion(.success(ref!.documentID as! T))
                        }
                    }
                }
            case .deletePost(let post):
                let documentId = post.id
                let db = Firestore.firestore()
                db.collection("posts").document(documentId).delete() { error in
                    if let error = error {
                        print("Error removing document: \(error)")
                        completion(.failure(error))
                    } else {
                        print("Document successfully removed!")
                        if let imageUrl = post.imageUrl {
                            let storage = Storage.storage()
                            let storageRef = storage.reference()
                            let ref = storageRef.child(imageUrl.absoluteString)

                            ref.delete { error in
                              if let error = error {
                                  completion(.failure(error))
                              } else {
                                  completion(.success(true as! T))
                              }
                            }
                        } else {
                            completion(.success(true as! T))
                        }
                    }
                }
        }
    }
}
