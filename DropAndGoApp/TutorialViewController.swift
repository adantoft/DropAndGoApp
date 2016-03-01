//
//  TutorialViewController.swift
//  DropAndGoApp
//
//  Created by Kayle Drucker on 2/29/16.
//  Copyright © 2016 D and D Software. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBAction func goToMainMenu(sender: UIBarButtonItem) {
        var top: UIViewController = self;
        while top.presentingViewController != nil {
            top = top.presentingViewController!;
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func backToGame(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
