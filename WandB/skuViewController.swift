//
//  skuViewController.swift
//  WandB
//
//  Created by mara shen on 15/7/15.
//  Copyright (c) 2015 mara shen. All rights reserved.
//

import UIKit

class skuViewController: UIViewController {

    @IBOutlet weak var enterSKUTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enterSKUButton(sender: UIButton) {
        
        //go to new scene for item
        presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: {
            NSNotificationCenter.defaultCenter().postNotificationName(mySpecialNotificationKey, object: self, userInfo: ["item":self.enterSKUTextField.text])
        })
    }

    @IBAction func cancelSKUButton(sender: UIButton) {
      dismissViewControllerAnimated(true, completion: nil)
    }
}
