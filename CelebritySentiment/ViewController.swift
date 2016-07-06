//
//  ViewController.swift
//  CelebritySentiment
//
//  Created by ajay singh on 6/18/16.
//  Copyright © 2016 Ajay. All rights reserved.
//

import UIKit

class EnterGroupViewController: UIViewController {

    @IBOutlet var groupNameTextField: UITextField!
    
    @IBOutlet var groupDescTextField: UITextField!
    
    var groupInfo : Groups  = Groups()
    
    @IBAction func onProceedBtnPressed(sender: AnyObject) {
        groupInfo.groupName = groupNameTextField.text
        groupInfo.groupDesc = groupDescTextField.text
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == "showGroup"{
            let showGroupSegue : GroupsTableViewController  = segue.destinationViewController  as! GroupsTableViewController
            showGroupSegue.group = groupInfo
            
        }
    }


}

