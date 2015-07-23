//
//  SearchCollectionViewController.swift
//  WandB
//
//  Created by mara shen on 20/7/15.
//  Copyright (c) 2015 mara shen. All rights reserved.
//

import UIKit

//let reuseIdentifier = "Cell"

class SearchCollectionViewController: UICollectionViewController {
    
    var parentNavigationController : UINavigationController?
    
    var backgroundPhotoNameArray : [String] = ["mood1.jpg", "mood2.jpg", "mood3.jpg", "mood4.jpg", "mood5.jpg", "mood6.jpg", "mood7.jpg", "mood8.jpg", "man1.jpg", "man2.jpg", "man3.jpg", "man4.jpg", "man5.jpg", "man6.jpg", "man7.jpg", "man8.jpg"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell nib
        self.collectionView!.registerNib(UINib(nibName: "RegistryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return backgroundPhotoNameArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : RegistryCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! RegistryCollectionViewCell
        
        // Configure the cell
        cell.coupleImageView.image = UIImage(named: backgroundPhotoNameArray[indexPath.row])
        cell.coupleLabel.text = "couple\(indexPath.row)"
        
        
        return cell
    }


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var controller : SelectedRegistryViewController = SelectedRegistryViewController(nibName: "SelectedRegistryViewController", bundle: nil)
        controller.title = "\(indexPath.row) Registry"
        parentNavigationController!.pushViewController(controller, animated: true)
        
        //performSegueWithIdentifier("registrySegue", sender: self)
        
    }


    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
}
