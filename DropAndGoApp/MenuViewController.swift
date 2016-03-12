//
//  MenuViewController.swift
//  DropAndGoApp
//
//  Created by Kayle Drucker on 3/1/16.
//  Copyright © 2016 D and D Software. All rights reserved.
//

import UIKit

let playerType = ["Player 2"]
let options = ["Against Computer", "Online Player"]

class MenuViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
        
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var playerNameField: UITextField!
    
    @IBAction func playGameButton(sender: UIButton) {
        
    }

    @IBAction func doneEditting(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func goToTutorial(sender: UIButton) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let target = segue.destinationViewController as? TutorialViewController{
            target.from = "MenuViewController"
        }
        
        if let target = segue.destinationViewController as? PlayGameViewController{
            if let player1 = playerNameField.text {
                target.player1 = "\(player1)"
                if (options[picker.selectedRowInComponent(1)] == "Against Computer") {
                    target.player2 = "Computer"
                } else {
                    target.player2 = "Online Player"
                }
                
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return playerType.count
        } else {
            return options.count
        }
    }
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return playerType[row]
        } else {
            return options[row]
        }
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