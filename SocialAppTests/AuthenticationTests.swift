//
//  AuthenticationTests.swift
//  SocialAppTests
//
//  Created by Spam C. on 2/8/23.
//

@testable import Yay
import XCTest
import FirebaseAuth

final class AuthenticationTests: XCTestCase {

    var loginViewModel: LoginViewModel!
    var signUpViewModel: SignUpViewModel!
    var accountViewModel: AccountViewModel!
    var handle: AuthStateDidChangeListenerHandle!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        loginViewModel = LoginViewModel()
        signUpViewModel = SignUpViewModel()
        accountViewModel = AccountViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        loginViewModel = nil
        signUpViewModel = nil
        accountViewModel = nil
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    func testSignOut() throws {
        accountViewModel.logout()
        
        let expectation = self.expectation(description: "sign out test")
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            XCTAssertNil(user, "User is not set to nil")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
           XCTAssertNil(error, "sign out test timed out")
        }
    }

    func testSignIn() throws {
        let email = "test@gmail.com"
        let password = "123456"

        let expectation = self.expectation(description: "sign in test")
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let loggedInEmail = user?.email {
                XCTAssertEqual(email, loggedInEmail, "User with email: " + email + " failed to sign in. current user: " + loggedInEmail)
                expectation.fulfill()
            }
        }
        
        accountViewModel.logout()
        loginViewModel.signIn(email: email, password: password)

        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error, "sign in test timed out")
        }
    }
    
    func testSignUp() throws {
        let number = Int.random(in: 0..<1000)
        let fullname = "EJ Cayabyab"
        let email = "test\(number)@gmail.com"
        let password = "123456"

        let expectation = self.expectation(description: "sign up test")
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let loggedInEmail = user?.email {
                XCTAssertEqual(email, loggedInEmail, "User with email: " + email + " failed to sign up. current user: " + loggedInEmail)
                expectation.fulfill()
            }
        }
        
        accountViewModel.logout()
        signUpViewModel.signUp(fullName: fullname, email: email, password: password)

        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error, "sign up test timed out")
        }
    }
}
