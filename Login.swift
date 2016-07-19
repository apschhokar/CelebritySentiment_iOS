//
//  Login.swift
//  CelebritySentiment
//
//  Created by ajay singh on 7/5/16.
//  Copyright © 2016 Ajay. All rights reserved.
//

import UIKit
import TwitterKit

class Login: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let alert = UIAlertController(title: "Logged In",
                    message: "User \(unwrappedSession.userName) has logged in",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:
                    { action in
                        switch action.style{
                            
                     //save userID so that it can be used later for twitter stream api
                        case .Default:
                            print("userID is\(session?.userID)")
                            let defaults = NSUserDefaults.standardUserDefaults()
                            defaults.setObject(session?.userID, forKey: "userID")
                            self.performSegueWithIdentifier("showGroup", sender: self)
                            print("default")
                            
                      // cancel case
                        case .Cancel:
                            print("cancel")
                            
                        case .Destructive:
                            print("destructive")
                        }
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        // TODO: Change where the log in button is positioned in your view
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }
    

    override func viewWillAppear(animated: Bool) {
    
        
        
    }
    
    
    
    
}
