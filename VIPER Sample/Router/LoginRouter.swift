//
//  LoginLoginRouter.swift
//  VIPER Sample
//
//  Created by Juani Perez on 12/06/2016.
//  Copyright © 2016 ComingWaves. All rights reserved.
//
import UIKit


class LoginRouter: LoginRouterInput {
    
    func showWelcomeViewController(fromVC:UIViewController) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            if let welcomeVC = fromVC.storyboard?.instantiateViewControllerWithIdentifier("WelcomeViewController") {
                
                fromVC.navigationController?.pushViewController(welcomeVC, animated: true)
            }
            
            })
        
    }
    
}
