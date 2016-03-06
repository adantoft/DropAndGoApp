//
//  TutorialViewController.swift
//  DropAndGoApp
//
//  Created by Kayle Drucker on 2/29/16.
//  Copyright © 2016 D and D Software. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var gameButton: UIBarButtonItem!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var fromDisplay: UILabel!
    
    var from = ""
    
    override func viewWillAppear(animated: Bool) {
        
        if from == "MenuViewController" {
            menuButton.enabled = true
        } else if from == "PlayGameViewController" {
            gameButton.enabled = true
        }
        
    }
    
    @IBAction func goToMainMenu(sender: UIBarButtonItem) {

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
