//
//  GroupsTableViewController.swift
//  CelebritySentiment
//
//  Created by ajay singh on 6/23/16.
//  Copyright © 2016 Ajay. All rights reserved.
//

import UIKit


class GroupsTableViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource{
    

    
    @IBOutlet weak var groupTableView: UITableView!
    
    override func viewDidLoad() {
        print("view did load was called")

        groupTableView.delegate = self
        groupTableView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        
        let nib = UINib(nibName: "GroupCell", bundle: nil)
        groupTableView.registerNib(nib, forCellReuseIdentifier: "groupCell")
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return 100
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        print("cell for row index path" )
        let cell : GroupViewTableCell = tableView.dequeueReusableCellWithIdentifier("groupCell") as! GroupViewTableCell!
        
        cell.groupName.text = "NBA"
        cell.groupDescription.text = "All About NBA"
        
        return cell
    }
    
    
}
