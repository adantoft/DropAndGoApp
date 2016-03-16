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
        
        tutorilaDisplay.text = "Welcome to the Drop and Go Game.\n\nIntroduction\nThis tutorial will help you with getting started and understand how to play the game so you can beat your opponent.\n\nGetting Started\nBefore you start the game, you need to enter your name. If left blank, your name will appear as \"player\". Next you will select who your opponent will be, either computer or online player.\n\nPlay the Game\nThe game will start once you tap a box in a column where you would like to drop your piece to make your moved. After you select you column, an X will appear on the board; then it will be your opponent's turn. You will be Xs and your opponent will be Os. Once each square is filled, with only one single square still available, the game will be over and final scores will be tallied. \n\nHow to Score BIG\nPoints are awarded based on the number of your pieces that are touching (connected to) each other. For every vertical or horizontal connection, you will earn 2 points. Diagonal connections will earn you 1 point. If you have box grouping of 4 (2 |x|x| on top and 2 |x|x| on bottom), you will earn 10 points: 4 horizontal, 4 vertical, 2 diagonal."
        
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
