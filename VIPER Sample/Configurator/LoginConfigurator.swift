//
//  LoginLoginConfigurator.swift
//  VIPER Sample
//
//  Created by Juani Perez on 12/06/2016.
//  Copyright © 2016 ComingWaves. All rights reserved.
//

import UIKit

class LoginModuleConfigurator {
    
    

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? LoginViewController {
            configure(viewController)
        }
    }

    
    
    private func configure(viewController: LoginViewController) {

        let router = LoginRouter()

        let presenter = LoginPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = LoginInteractor(authService:RemoteAuthService())
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
