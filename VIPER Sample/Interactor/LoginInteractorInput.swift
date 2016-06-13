//
//  LoginLoginInteractorInput.swift
//  VIPER Sample
//
//  Created by Juani Perez on 12/06/2016.
//  Copyright © 2016 ComingWaves. All rights reserved.
//

import Foundation

protocol LoginInteractorInput {

    func performLoginAPICall(username:String, pass:String)
}
