//
//  AuthService.swift
//  MVVM Sample
//
//  Created by Juani on 10/06/2016.
//  Copyright © 2016 Juani. All rights reserved.
//

import Foundation




protocol AuthService {
    
    func login(user:User, response:(data:NSData?, error:NSError?) -> (Void))   
    
}