//
//  itemViewController.swift
//  WandB
//
//  Created by mara shen on 15/7/15.
//  Copyright (c) 2015 mara shen. All rights reserved.
//

import UIKit

class itemViewController: UIViewController {
    
    @IBOutlet weak var barcodeLabel: UILabel!
    var barcodeString = ""
    var isItemAdded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchItem : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "searchBarButton")
        self.navigationItem.rightBarButtonItem = searchItem

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        barcodeLabel.text = barcodeString
        isItemAdded = false
    }
    

    override func viewDidDisappear(animated: Bool) {
        if isItemAdded{
            NSNotificationCenter.defaultCenter().postNotificationName(alertNotificationKey, object: self, userInfo: ["item":self.barcodeString])
        }
    }
    
    //MARK: -Actions
    
    @IBAction func addItemButton(sender: AnyObject) {
    
        isItemAdded = true
        self.navigationController?.popViewControllerAnimated(true)
        //add to item array
    }
    
    func searchBarButton() {
        //go to newview for searching
        
        var SVC : NewViewController = NewViewController(nibName: "NewViewController", bundle: nil)
        SVC.title = "Search"
        self.navigationController?.pushViewController(SVC, animated: true)
        
    }

    
    @IBAction func cancelItemButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
