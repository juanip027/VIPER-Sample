//
//  LoginLoginInteractor.swift
//  VIPER Sample
//
//  Created by Juani Perez on 12/06/2016.
//  Copyright © 2016 ComingWaves. All rights reserved.
//
import Foundation


class LoginInteractor: LoginInteractorInput {

    weak var output: LoginInteractorOutput!
    let authService : AuthService!
    
    init(authService:AuthService) {
        self.authService = authService
    }
    
    func performLoginAPICall(username:String, pass:String) {
        
        // Fake Network call
        
        self.authService.login(User(username:username, password: pass)) { (data, error) -> (Void) in
            
            let genericError = NSError(domain: "Network/Server Error", code: 100, userInfo: nil)
            do {
                if let data = data,
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String:AnyObject] {
                    
                    let currentUser = User.decode(json)
                    
                    if currentUser.isValid() {
                        
                        // set here local current user here
                        
                        self.output.loginDidComplete()
                        
                    } else {
                        
                        let code:Int? = json["errorCode"]?.integerValue
                        self.output.loginDidFailWithError(NSError(domain: "Invalid LOGIN Error", code: code!, userInfo: nil))

                    }
                    
                } else {
                    self.output.loginDidFailWithError(error ?? genericError)
                }
            } catch {
                self.output.loginDidFailWithError(genericError)
            }

            
        }
        
        
    }
}
