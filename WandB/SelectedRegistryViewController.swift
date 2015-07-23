//
//  SelectedRegistryViewController.swift
//  WandB
//
//  Created by mara shen on 15/7/15.
//  Copyright (c) 2015 mara shen. All rights reserved.
//

import UIKit

let mySpecialNotificationKey = "notificationKey"
let alertNotificationKey = "alertNotif"
class SelectedRegistryViewController: UIViewController {

    //MARK: -Properties
    
    //couple details
    @IBOutlet weak var coupleImageView: UIImageView!
    @IBOutlet weak var coupleFirstNameLabel: UILabel!
    @IBOutlet weak var coupleNuptialLabel: UILabel!
    @IBOutlet weak var weddingDateLabel: UILabel!
    
    @IBOutlet weak var guestCountLabel: UILabel!
    @IBOutlet weak var reservedItemsLabel: UILabel!
    
    //add item button
    @IBOutlet weak var addItemImageView: UIImageView!
    @IBOutlet weak var addItemView: UIView!
    
    @IBOutlet weak var pageMenuView: UIView!
    
    var pageMenu2 : CAPSPageMenu?
    //store controller arrays
    var controllerArray : [UIViewController] = []
    
    //navigationController
    var parentNavigationController : UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configure navigationbar
        let searchItem : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "searchBarButton")
        self.navigationItem.rightBarButtonItem = searchItem
        
        // add controller for pagemenu

        // Do any additional setup after loading the view.
        var controller1 : ProductCollectionViewController = ProductCollectionViewController(nibName:"ProductCollectionViewController", bundle: nil)
        controller1.title = "All Items in Registry"
        controller1.displayProduct = ["mood1.jpg", "mood2.jpg", "mood3.jpg", "mood4.jpg", "mood5.jpg", "mood6.jpg", "mood7.jpg", "mood8.jpg", "man1.jpg", "man2.jpg", "man3.jpg", "man4.jpg", "man5.jpg", "man6.jpg", "man7.jpg", "man8.jpg"]
        controller1.parentNavigationController = self.navigationController
        controllerArray.append(controller1)
        
        var controller2 : ProductCollectionViewController = ProductCollectionViewController(nibName:"ProductCollectionViewController", bundle: nil)
        controller2.title = "Reserved and Purchased"
        controller2.displayProduct = ["man1.jpg", "man2.jpg", "man3.jpg", "man4.jpg", "man5.jpg", "man6.jpg", "man7.jpg", "man8.jpg"]
        controller2.parentNavigationController = self.navigationController
        controllerArray.append(controller2)
        
        var controller3 : ProductCollectionViewController = ProductCollectionViewController(nibName:"ProductCollectionViewController", bundle: nil)
        controller3.title = "Available"
        controller3.displayProduct = ["mood1.jpg", "mood2.jpg", "mood3.jpg", "mood4.jpg", "mood5.jpg", "mood6.jpg", "mood7.jpg", "mood8.jpg"]
        controller3.parentNavigationController = self.navigationController
        controllerArray.append(controller3)
        
        // Customize page menu
        var parameters: [CAPSPageMenuOption] = [
            .UseMenuLikeSegmentedControl(true),
            .MenuHeight(40.0),
            .CenterMenuItems(true),
            .SelectionIndicatorHeight(2.0),
            .SelectionIndicatorColor(UIColor(red: 0.23, green:0.78, blue:0.48, alpha:1.0)),
            .ScrollMenuBackgroundColor(UIColor.whiteColor()),
            .SelectedMenuItemLabelColor(UIColor(red: 0.23, green:0.78, blue:0.48, alpha:1.0)),
            .UnselectedMenuItemLabelColor(UIColor.grayColor()),
            .AddBottomMenuHairline(false),
            .MenuItemFont(UIFont.systemFontOfSize(20.0))
        ]

        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu2 = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, pageMenuView.frame.width, pageMenuView.frame.height), pageMenuOptions: parameters)
        
        println("subviewheight \(pageMenuView.frame.height)")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotoItemView:", name: mySpecialNotificationKey, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addAlertNotif:", name: alertNotificationKey, object: nil)
        
    }
    
    override func viewDidLayoutSubviews() {
        var size: CGSize = coupleImageView.frame.size
        coupleImageView.layer.cornerRadius = size.width/2
        coupleImageView.layer.masksToBounds = true
        
        var size2: CGSize = addItemImageView.frame.size
        addItemImageView.layer.cornerRadius = size2.width/2
        addItemImageView.layer.masksToBounds = true
        
        pageMenuView.addSubview(pageMenu2!.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK -Notification Selector
    func gotoItemView(notification:NSNotification){
        let userInfo:Dictionary<String,String!> = notification.userInfo as! Dictionary<String,String!>
        let itemString = userInfo["item"]
        
        var itemController : itemViewController = itemViewController(nibName: "itemViewController", bundle: nil)
        itemController.title = "Item"
        itemController.barcodeString = itemString!
    
        self.navigationController!.pushViewController(itemController, animated: false)
        println("notificationdone")
    }
    
    func addAlertNotif(notification:NSNotification){
        let userInfo:Dictionary<String,String!> = notification.userInfo as! Dictionary<String,String!>
        let itemString = userInfo["item"]
        
        var alert = UIAlertController(title: "Success", message: "added item " + itemString!, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: -Actions
    
    @IBAction func addItemButton(sender: UIButton) {
        var cameraController : CameraViewController = CameraViewController(nibName:"CameraViewController", bundle: nil)
        cameraController.title = "cameracontroller"
        presentViewController(cameraController, animated: true, completion: nil)
    }
    
    func searchBarButton() {
        //go to newview for searching
        
        var SVC : NewViewController = NewViewController(nibName: "NewViewController", bundle: nil)
        SVC.title = "Search"
        self.navigationController?.pushViewController(SVC, animated: true)
    }

    
    //MARK: -Orientation
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }

}
