//
//  LoginLoginPresenterTests.swift
//  VIPER Sample
//
//  Created by Juani Perez on 12/06/2016.
//  Copyright © 2016 ComingWaves. All rights reserved.
//

import XCTest
@testable import VIPER_Sample

class LoginPresenterTest: XCTestCase {

    var presenter : LoginPresenter!
    weak var view: LoginViewInput!
    var interactor: MockInteractor!
    var router: MockRouter!
    var viewController : MockViewController!
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.router = MockRouter()
        self.viewController = MockViewController()
        self.interactor = MockInteractor()
        
        presenter = LoginPresenter()
        
        presenter.view = self.viewController
        presenter.router = self.router
        
        interactor.output = self.presenter
        presenter.interactor = self.interactor
        
        viewController.output = self.presenter

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: LoginInteractorInput {

        var output : LoginInteractorOutput!
        
        func performLoginAPICall(username: String, pass: String) {
            
            if username == "juani" && pass == "123" {
                output.loginDidComplete()
            } else {
                output.loginDidFailWithError(NSError(domain: "user/pass don't match", code: 1, userInfo: nil))
            }
        }
        
    }

    class MockRouter: LoginRouterInput {
        var inputCallbackResults = [String:AnyObject]()
        
        func showWelcomeViewController(fromVC: UIViewController) {
            inputCallbackResults["showWelcomeViewController"] = fromVC
        }
    }

    class MockViewController: UIViewController, LoginViewInput {
        
        var output:LoginViewOutput!
        var inputCallbackResults = [String:AnyObject]()
        
        func setupInitialState() {
            inputCallbackResults["setupInitialState"] = ""
        }
        
        func showErrorMessage(message: String) {
            inputCallbackResults["showErrorMessage"] = message
            
        }
    }
    
    
    
    // MARK: Tests
    
    func testEmptyUsername() {
        let form = (username:"",password:"123")
        XCTAssertFalse(presenter.isValidLoginForm(form.username, pass: form.password))

        presenter.performLogin(form.username, pass: form.password)
        XCTAssertEqual(viewController.inputCallbackResults["showErrorMessage"]?.description, "Username and password can't be empty.")
        XCTAssertFalse(router.inputCallbackResults.keys.contains("showWelcomeViewController"))

    }
    
    func testEmptyPassword() {
        let form = (username:"juani",password:"")
        XCTAssertFalse(presenter.isValidLoginForm(form.username, pass: form.password))

        presenter.performLogin(form.username, pass: form.password)
        XCTAssertEqual(viewController.inputCallbackResults["showErrorMessage"]?.description, "Username and password can't be empty.")
        XCTAssertFalse(router.inputCallbackResults.keys.contains("showWelcomeViewController"))
    }
    
    func testWrongPassword() {
        let form = (username:"juani",password:"111")
        XCTAssertTrue(presenter.isValidLoginForm(form.username, pass: form.password))

        presenter.performLogin(form.username, pass: form.password)
        XCTAssertEqual(viewController.inputCallbackResults["showErrorMessage"]?.description, "Localized LOGIN error for code: 1 try juani/123")
        XCTAssertFalse(router.inputCallbackResults.keys.contains("showWelcomeViewController"))
    }
    
    func testLoginSuccess() {
        let form = (username:"juani",password:"123")
        XCTAssertTrue(presenter.isValidLoginForm(form.username, pass: form.password))

        presenter.performLogin(form.username, pass: form.password)
        XCTAssertTrue(router.inputCallbackResults.keys.contains("showWelcomeViewController"))
    }
    
    
}
