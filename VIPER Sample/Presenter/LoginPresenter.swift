//
//  LoginLoginPresenter.swift
//  VIPER Sample
//
//  Created by Juani Perez on 12/06/2016.
//  Copyright © 2016 ComingWaves. All rights reserved.
//
import UIKit

class LoginPresenter: LoginModuleInput, LoginViewOutput, LoginInteractorOutput {

    weak var view: LoginViewInput!
    var interactor: LoginInteractorInput!
    var router: LoginRouterInput!

    func viewIsReady() {
    
    }
    
    func isValidLoginForm(username:String?, pass:String?) -> Bool {
        if let username = username,
            pass = pass
            where !username.isEmpty && !pass.isEmpty {
            
            return true
            
        } else {
            return false
        }
        
    }
    
    func performLogin(username:String, pass:String)  {
        
        if self.isValidLoginForm(username, pass: pass) {
            
            self.interactor.performLoginAPICall(username, pass: pass)
            
        } else {
            view.showErrorMessage("Username and password can't be empty.")
        }
        
    }
    
    // MARK: LoginInteractorOutput
    
    func loginDidComplete() {
        
        if let from = self.view as? UIViewController {
            self.router.showWelcomeViewController(from)
        }
    }
    
    func loginDidFailWithError(error: NSError) {
        switch error.code {
        case 1:
            view.showErrorMessage("Localized LOGIN error for code: \(error.code) try juani/123")
        default:
            view.showErrorMessage("Localized NETWORK error for code: \(error.code). Run the MockRestServlet.rb in your terminal.")
        }
        
    }
}
