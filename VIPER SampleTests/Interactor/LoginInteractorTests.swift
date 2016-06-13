//
//  LoginLoginInteractorTests.swift
//  VIPER Sample
//
//  Created by Juani Perez on 12/06/2016.
//  Copyright © 2016 ComingWaves. All rights reserved.
//

import XCTest
@testable import VIPER_Sample

class LoginInteractorTests: XCTestCase {

    var presenter : MockPresenter!
    var interactor: LoginInteractor!
    var authService: MockAuthService!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.presenter = MockPresenter()
        self.authService = MockAuthService()
        self.interactor = LoginInteractor(authService: self.authService)
        self.interactor.output = presenter
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    class MockPresenter: LoginInteractorOutput {

        
        var inputCallbackResults = [String:AnyObject]()
        
        func loginDidComplete() {
            inputCallbackResults["loginDidComplete"] = ""
        }

        func loginDidFailWithError(error: NSError) {
            inputCallbackResults["loginDidFailWithError"] = error
        }
        
    }
    
    // MARK: Tests
    
    func testWrongPassword() {
        self.interactor.performLoginAPICall("juani", pass: "111")
        XCTAssertEqual((presenter.inputCallbackResults["loginDidFailWithError"] as? NSError)?.code, 1)
        XCTAssertFalse(presenter.inputCallbackResults.keys.contains("loginDidComplete"))
    }
    
    func testLoginSuccess() {
        self.interactor.performLoginAPICall("juani", pass: "123")
        XCTAssertTrue(presenter.inputCallbackResults.keys.contains("loginDidComplete"))
        XCTAssertFalse(presenter.inputCallbackResults.keys.contains("loginDidFailWithError"))
    }
    
    func testNetworkError() {
        self.authService.simulateNetworkError = true
        self.interactor.performLoginAPICall("juani", pass: "123")
        XCTAssertEqual((presenter.inputCallbackResults["loginDidFailWithError"] as? NSError)?.code, 100)
        XCTAssertFalse(presenter.inputCallbackResults.keys.contains("loginDidComplete"))
    }
    
    
}
