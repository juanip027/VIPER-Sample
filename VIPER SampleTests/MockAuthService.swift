//
//  MockAuthService.swift
//  MVVM Sample
//
//  Created by Juani on 11/06/2016.
//  Copyright © 2016 Juani. All rights reserved.
//

import Foundation
@testable import VIPER_Sample

class MockAuthService : NSObject, AuthService {
    
    var simulateNetworkError = false

    func login(user:User, response:(data:NSData?, error:NSError?) -> (Void))  {

        if self.simulateNetworkError {
            response(data: nil, error: NSError(domain: "invalid Json", code: 100, userInfo: ["user": user]))
            
        } else {
            
            var responseObject:AnyObject?
            let validLogin = user.username == "juani" && user.password == "123"
            if validLogin {
                
                user.password = ""
                responseObject = User.encode(user)
                
            } else {
                
                var errorResponseObject = [String: AnyObject]()
                errorResponseObject["errorCode"] = "1"
                responseObject = errorResponseObject
            }
            
            let responseData = try! NSJSONSerialization.dataWithJSONObject(responseObject!, options: NSJSONWritingOptions.PrettyPrinted)
            response(data: responseData, error: nil)

            
        }
        
    }
    

}