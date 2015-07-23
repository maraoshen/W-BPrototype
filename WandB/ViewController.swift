//
//  ViewController.swift
//  WandB
//
//  Created by mara shen on 14/7/15.
//  Copyright (c) 2015 mara shen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: -Properties
    
    var pageMenu: CAPSPageMenu?
    var controllerArray: [UIViewController] = []    //Array for controllers in pagemenu
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init controllers in pagemenu
        var controller1 : RegistryCollectionViewController = RegistryCollectionViewController(nibName: "RegistryCollectionViewController", bundle: nil)
        controller1.parentNavigationController = self.navigationController
        controller1.title = "Registries"
        controllerArray.append(controller1)
        
        var controller2 : ProductCollectionViewController = ProductCollectionViewController(nibName: "ProductCollectionViewController", bundle: nil)
        controller2.parentNavigationController = self.navigationController
        controller2.title = "Products and Collections"
        controller2.displayProduct = controller2.backgroundPhotoNameArray   //set displayProduct array
        controllerArray.append(controller2)

        //customize pagemenu
        var parameters: [CAPSPageMenuOption] = [
            .UseMenuLikeSegmentedControl(true),
            .MenuHeight(40.0),
            .CenterMenuItems(true),
            .SelectionIndicatorHeight(2.0),
            .SelectionIndicatorColor(UIColor(red: 0.24, green:0.54, blue:0.89, alpha:1.0)),
            .ScrollMenuBackgroundColor(UIColor.whiteColor()),
            .SelectedMenuItemLabelColor(UIColor(red: 0.24, green:0.54, blue:0.89, alpha:1.0)),
            .UnselectedMenuItemLabelColor(UIColor.blackColor()),
            .AddBottomMenuHairline(false),
            .MenuItemFont(UIFont.systemFontOfSize(20.0))
        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, mainView.frame.width, mainView.frame.height), pageMenuOptions: parameters)
        
        //add page menu as subview of base view controller view
        mainView.addSubview(pageMenu!.view)

    }
    
    override func viewDidAppear(animated: Bool) {
        
        //go to login scene if not logged in
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        if(!isUserLoggedIn){
            self.performSegueWithIdentifier("loginSegue", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -Actions
    
    @IBAction func logoutButton(sender: UIBarButtonItem) {
       
        //configuration for drawer
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    @IBAction func searchBarButton(sender: UIBarButtonItem) {
        
        //go to NewViewController for searching
        var SVC : NewViewController = NewViewController(nibName: "NewViewController", bundle: nil)
        SVC.title = "Search"
        self.navigationController?.pushViewController(SVC, animated: true)
    
    }
    
    //MARK: -Orientation
    
    override func supportedInterfaceOrientations() -> Int {
        
        //only supports portrait orientation
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }

    

}

