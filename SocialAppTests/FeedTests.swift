//
//  FeedTests.swift
//  SocialAppTests
//
//  Created by Spam C. on 2/8/23.
//

@testable import Yay
import XCTest

final class FeedTests: XCTestCase {

    var post: Post!
    var user: User!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        user = User(id: "abcdefg", name: "EJ Cayabyab", profileImageUrl: URL(string: "https://play-lh.googleusercontent.com/wlPBF6QthhbJhH99IBAIcMaRmmwSPmQEABMA2mhJmS4OWU9bdWV0ZRlsm6QDrtPkZZM"))
        post = Post(id: "uvwxyz", user: user, message: "sample message", imageUrl: nil, timestamp: "1 min ago")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        user = nil
        post = nil
    }

    func testGetPosts() throws {
        let viewModel = FeedViewModel()
        
        let expectation = self.expectation(description: "get posts test")
        
        viewModel.posts.addObserver { posts in
            XCTAssertNotNil(posts, "Post not fetched successfully")
            expectation.fulfill()
        }
        
        viewModel.getPosts()
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error, "get posts test timed out")
        }
    }
    
    func testAddThenDeletePost() throws {
        let addPostViewModel = AddPostViewModel()
        addPostViewModel.user = user
        
        let expectation = self.expectation(description: "add then delete post test")
        addPostViewModel.addPost(message: post.message ?? "", postImageUrl: nil) { [weak self] postId in
            XCTAssertNotNil(postId, "Post not added successfully")
            let postOptionsViewModel = PostOptionsViewModel()
            self?.post.id = postId
            postOptionsViewModel.post = self?.post
            postOptionsViewModel.deletePost { success in
                XCTAssertTrue(success, "Post not deleted successfully")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error, "add then delete post test timed out")
        }
    }
}
