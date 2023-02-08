//
//  ViewModelTests.swift
//  SocialAppTests
//
//  Created by Spam C. on 2/8/23.
//

@testable import Yay
import XCTest

final class ViewModelTests: XCTestCase {

    var post: Post!
    var user: User!
    
    override func setUpWithError() throws {
        user = User(id: "abcdefg", name: "EJ Cayabyab", profileImageUrl: URL(string: "https://play-lh.googleusercontent.com/wlPBF6QthhbJhH99IBAIcMaRmmwSPmQEABMA2mhJmS4OWU9bdWV0ZRlsm6QDrtPkZZM"))
        post = Post(id: "uvwxyz", user: user, message: "sample message", imageUrl: nil, timestamp: "1 min ago")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        post = nil
        user = nil
    }

    func testPostViewModel() {
        let viewModel = PostViewModel()
        viewModel.post = post
        
        XCTAssertEqual(post.user.name, viewModel.name, "Name not properly set")
        XCTAssertEqual(post.timestamp, viewModel.timestamp, "Timestamp not properly set")
        XCTAssertEqual(post.message, viewModel.message, "Message not properly set")
        XCTAssertEqual(post.imageRef, viewModel.imagePostRef, "Image Ref not properly set")
        XCTAssertEqual(post.user.profileImageUrl, viewModel.imageUserUrl, "Image URL not properly set")
    }
    
    func testAddPostViewModel() {
        let viewModel = AddPostViewModel()
        viewModel.user = user
        
        XCTAssertEqual(user.firstName, viewModel.firstName, "First name not properly set")
        XCTAssertEqual(user.name, viewModel.name, "Name not properly set")
        XCTAssertEqual(user.profileImageUrl, viewModel.imageUserUrl, "Image URL not properly set")
    }
    
    func testAccountViewModel() {
        let viewModel = AccountViewModel()
        viewModel.user = user
        
        XCTAssertEqual(user.profileImageUrl, viewModel.imageProfileUrl, "Image URL not properly set")
    }

    func testUserCellViewModel() {
        let viewModel = UserCellViewModel()
        viewModel.user = user
        
        XCTAssertEqual(user.profileImageUrl, viewModel.imageProfileUrl, "Image URL not properly set")
        XCTAssertEqual(user.firstName, viewModel.firstName, "First name not properly set")
        XCTAssertEqual(AppColor.Gradient, viewModel.backgroundColor, "Background color not properly set")
        
        viewModel.isMainUser = true
        
        XCTAssertEqual("My Profile", viewModel.firstName, "First name not properly set")
        XCTAssertEqual(AppColor.Border, viewModel.backgroundColor, "Background color not properly set")
    }
    
    func testPostCellViewModel() {
        let viewModel = PostCellViewModel()
        viewModel.post = post
        viewModel.user = user
        
        XCTAssertEqual(user.id == post.user.id, viewModel.isPostDeletable, "isPostDeletable not properly set")
        XCTAssertEqual(post.user.profileImageUrl, viewModel.imageProfileUrl, "Image URL not properly set")
        XCTAssertEqual(post.user.name, viewModel.name, "Name not properly set")
        XCTAssertEqual(post.timestamp, viewModel.timestamp, "Timestamp not properly set")
        XCTAssertEqual(post.message, viewModel.message, "Message not properly set")
        XCTAssertEqual(post.imageRef, viewModel.imagePostRef, "Image Post ref not properly set")
    }
}
