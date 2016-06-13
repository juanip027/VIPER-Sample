//
//  LoginLoginViewController.swift
//  VIPER Sample
//
//  Created by Juani Perez on 12/06/2016.
//  Copyright © 2016 ComingWaves. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginViewInput, UITextFieldDelegate {

    var output: LoginViewOutput!

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var errorMessageLabel: UILabel!
    @IBOutlet var loginButton: UIButton!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        passwordTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        usernameTextField.becomeFirstResponder()
        
        output.viewIsReady()
        
    }
    
    func textFieldDidChange(textField:UITextField) {
        loginButton.enabled = self.output.isValidLoginForm(usernameTextField.text, pass: passwordTextField.text)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        errorMessageLabel.alpha = 0

    }

    @IBAction func handleLogin(sender: AnyObject) {
        self.output.performLogin(usernameTextField.text ?? "", pass: passwordTextField.text ?? "")
    }

    // MARK: LoginViewInput
    func setupInitialState() {
        
    }
    
    
    func showErrorMessage(message: String) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.errorMessageLabel.alpha = 0
            self.errorMessageLabel.text = message
            
            UIView.animateWithDuration(0.3) {
                self.errorMessageLabel.alpha = 1
            }
            })
        
        
    }
}
