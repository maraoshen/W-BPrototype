//
//  NewViewController.swift
//  WandB
//
//  Created by mara shen on 15/7/15.
//  Copyright (c) 2015 mara shen. All rights reserved.
//

import UIKit

class NewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating {

    //MARK: -Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBarPlaceholder: UIView!
    
    var data : [String] = ["mood1.jpg", "mood2.jpg", "mood3.jpg", "mood4.jpg", "mood5.jpg", "mood6.jpg", "mood7.jpg", "mood8.jpg", "man1.jpg", "man2.jpg", "man3.jpg", "man4.jpg", "man5.jpg", "man6.jpg", "man7.jpg", "man8.jpg"]

    var filteredData: [String]!
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell nib
        collectionView.registerNib(UINib(nibName: "RegistryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        collectionView.delegate = self
        collectionView.dataSource = self
        filteredData = data
        
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
        searchBarPlaceholder.addSubview(searchController.searchBar)
        searchController.hidesNavigationBarDuringPresentation = false
        automaticallyAdjustsScrollViewInsets = false
        definesPresentationContext = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -SearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController){
        
        let searchText = searchController.searchBar.text
        
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
        })
        
        collectionView.reloadData()
    }
    
    //MARK: -UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return filteredData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : RegistryCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! RegistryCollectionViewCell
        
        // Configure the cell
        cell.coupleImageView.image = UIImage(named: filteredData[indexPath.row])
        cell.coupleLabel.text = "couple\(indexPath.row)"
        
        
        return cell
    }
    
    //MARK: -UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var controller : SelectedRegistryViewController = SelectedRegistryViewController(nibName: "SelectedRegistryViewController", bundle: nil)
        controller.title = "\(indexPath.row) Registry"
        self.navigationController!.pushViewController(controller, animated: true)

    }

}
