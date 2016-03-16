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
    
    @IBOutlet weak var tutorilaDisplay: UILabel!
    var from = ""
    
    override func viewWillAppear(animated: Bool) {
        
        if from == "MenuViewController" {
            menuButton.enabled = true
        } else if from == "PlayGameViewController" {
            gameButton.enabled = true
        }
        
        tutorilaDisplay.text = "Welcome to the Drop and Go Game.\n\n Introduction\n This tutorial will help you with getting started and understand how to play the game so you can beat your opponent.\n\n Getting Started\n Before you start the game, you need to enter your name. If left blanked your name will appear as \"player\". Next you will select who your opponent will be, either computer or online player.\n\n Play the Game\n The game will start once you click a box in a column you like to drop your piece. After you select you column an X will appear on the board, then it will be your opponents turn. You will be Xs and your opponent will be Os. Once each square is filled, with only one single square still available, then you have completed the game. \n\n How to Score BIG\n For every move vertical or horizontal, you will earn 2 points. Diagonal plays will earn you 1 point. If you have box grouping of 4 ( 2 |x|x| on top and 2 |x|x| on bottom), you will earn 4 points."
        
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
