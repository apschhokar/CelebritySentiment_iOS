//
//  GroupsTableViewController.swift
//  CelebritySentiment
//
//  Created by ajay singh on 6/23/16.
//  Copyright © 2016 Ajay. All rights reserved.
//

import UIKit

class GroupsTableViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource{
    

   var group :Groups = Groups()
    
    @IBOutlet weak var groupTableView: UITableView!
    
    override func viewDidLoad() {
        print("view did load was called")

        groupTableView.delegate = self
        groupTableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        print("cell for row index path")

        var temo :UITableViewCell = UITableViewCell()
        
        return temo
    }
    
    
}
