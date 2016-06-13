//
//  User.swift
//  MVVM Sample
//
//  Created by Juani on 10/06/2016.
//  Copyright © 2016 Juani. All rights reserved.
//

import Foundation

enum UserError: ErrorType {
    case InvalidDecodeData
}

final class User: NSObject  {
    
    var username: String
    var password: String
    
    override init() {
        username = ""
        password = ""
    }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    func isValid() -> Bool {
        return username.characters.count > 0
    }

    

    class func decode(json: [String:AnyObject]) -> User {
        return User(
            username: json["username"]?.description ?? "",
            password: json["password"]?.description ?? ""
        )
    }
    
    class func encode(object: User) -> AnyObject {
        
        var user = [String: AnyObject]()
        
        user["username"] = object.username
        user["password"] = object.password

        return user
    }
    
}


