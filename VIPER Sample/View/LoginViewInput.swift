//
//  LoginLoginViewInput.swift
//  VIPER Sample
//
//  Created by Juani Perez on 12/06/2016.
//  Copyright © 2016 ComingWaves. All rights reserved.
//

protocol LoginViewInput: class {

    /**
        @author Juani Perez
        Setup initial state of the view
    */

    func setupInitialState()
    func showErrorMessage(message:String)
    
}
