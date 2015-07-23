//
//  LoginViewController.swift
//  WandB
//
//  Created by mara shen on 14/7/15.
//  Copyright (c) 2015 mara shen. All rights reserved.
//

import UIKit

let concierge = "concierge"
let pass = "1234"

class LoginViewController: UIViewController {

    // Mark: -Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -Actions
    
    @IBAction func loginButton(sender: UIButton) {
    
        if concierge == usernameTextField.text && pass == passwordTextField.text{
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
            self.dismissViewControllerAnimated(true, completion: nil)
        }else {
            //insert alert
            println("error")
        }
        
    }
    
}
