//
//  SideViewController.swift
//  WandB
//
//  Created by mara shen on 20/7/15.
//  Copyright (c) 2015 mara shen. All rights reserved.
//

import UIKit

class SideViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: -Properties
    @IBOutlet weak var tableView: UITableView!
     var menuItems:[String] = ["Home","About", "Logout"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "SideTableViewCell", bundle: nil), forCellReuseIdentifier: "tablecell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //check if user is logged in.
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        if(!isUserLoggedIn){
            self.performSegueWithIdentifier("loginSegue", sender: self)
        }else{
            var centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
            
            var centerNavController = UINavigationController(rootViewController: centerViewController)
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: false, completion: nil)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell: SideTableViewCell = tableView.dequeueReusableCellWithIdentifier("tablecell", forIndexPath: indexPath) as! SideTableViewCell
        cell.sideMenuLabel.text = menuItems[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        println("\(indexPath.row)")
        
        switch(indexPath.row){
        
        case 0: //centerview
        
            var centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
            
            var centerNavController = UINavigationController(rootViewController: centerViewController)
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
            break;
            
        case 2: //logout
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            self.performSegueWithIdentifier("loginSegue", sender: self)
            break;
            
        default:
        
        println("\(menuItems[indexPath.row]) is selected")
        
        }
        
    }

}
