//
//  LoginLoginViewOutput.swift
//  VIPER Sample
//
//  Created by Juani Perez on 12/06/2016.
//  Copyright © 2016 ComingWaves. All rights reserved.
//

protocol LoginViewOutput {
    
    func viewIsReady()
    func performLogin(username:String, pass:String)
    func isValidLoginForm(username:String?, pass:String?) -> Bool
}
