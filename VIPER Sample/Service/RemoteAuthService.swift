//
//  AuthService.swift
//  MVVM Sample
//
//  Created by Juani on 10/06/2016.
//  Copyright © 2016 Juani. All rights reserved.
//

import Foundation

class RemoteAuthService : NSObject, AuthService {
    
    let host = "http://localhost:9955/AuthService/"
    
    private func requestWithBody(path: String, method: String, body: NSData) -> NSMutableURLRequest {
        let request : NSMutableURLRequest = NSMutableURLRequest()
        
        request.URL = NSURL(string: host + path)
        request.HTTPMethod = method
        if method == "POST" {
                request.HTTPBody = body
        }
        
        return request
    }

    
    func login(user:User, response:(data:NSData?, error:NSError?) -> (Void))  {
        do {
        let jsonData = try NSJSONSerialization.dataWithJSONObject(User.encode(user), options: NSJSONWritingOptions.PrettyPrinted)
            let request = self.requestWithBody("login", method: "POST", body: jsonData)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, _, error) in
                response(data: data, error: error)
            })
            
            task.resume()
        } catch {
            response(data: nil, error: NSError(domain: "invalid Json", code: 1, userInfo: ["user": user]))
        }
        
    }
    
    
}