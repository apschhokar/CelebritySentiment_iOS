//
//  ViewController.swift
//  CelebritySentiment
//
//  Created by ajay singh on 6/18/16.
//  Copyright © 2016 Ajay. All rights reserved.
//

import UIKit

class EnterGroupViewController: UIViewController {

    //uicontrols outlets.
    @IBOutlet weak var headingText: UILabel!
    @IBOutlet var groupNameTextField: UITextField!
    
    @IBOutlet weak var proceedButton: UIButton!
    
    @IBAction func onProceedBtnPressed(sender: AnyObject) {
        
        if proceedButton.titleLabel?.text == "ok"{
            performSegueWithIdentifier("listGroup", sender: self)
            return
        }
        
        
        self.headingText.hidden = false
        self.groupNameTextField.hidden = false
        
        
        //animation for ui controls
        
        let options = UIViewAnimationOptions.CurveEaseOut
        
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 2.0, options: options, animations:{
             self.headingText.frame = CGRect(x:13-300 , y: 125, width: 329, height: 96)
        } , completion:nil)
        
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 2.0, options: options, animations:{
            self.groupNameTextField.frame = CGRect(x:98-(-200) , y: 254, width: 179, height: 30)
            } , completion:nil)
        
        
        
        // chnage some value for proceed button
        self.proceedButton.setTitle("ok", forState: UIControlState.Normal)
        self.proceedButton.titleLabel!.font = UIFont(name: "...", size: 20)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.groupNameTextField.hidden = true
        self.headingText.hidden = true
        self.proceedButton.layer.cornerRadius = 20
        
        // uianimaton
        let duration = 1.0
        let options = UIViewAnimationOptions.CurveEaseOut
    
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: options, animations: {
            self.proceedButton.frame = CGRect(x: 131, y: 352-700, width: 90, height: 40)

            }, completion: nil)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == "listGroup"{
            let showGroupSegue : GroupsTableViewController  = segue.destinationViewController  as! GroupsTableViewController
            
        }
    }


}

