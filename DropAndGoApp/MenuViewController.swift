//
//  MenuViewController.swift
//  DropAndGoApp
//
//  Created by Kayle Drucker on 3/1/16.
//  Copyright © 2016 D and D Software. All rights reserved.
//

import UIKit

let playerType = ["Player 2"]
let options = ["Computer", "Online Player"]

class MenuViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
        
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var playerNameField: UITextField!
    var message = ""
    
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
                target.p1Name = "\(player1)"
                if (options[picker.selectedRowInComponent(1)] == "Computer") {
                    target.p2Name = "Computer"
                } else {
                    target.p2Name = "Online Player"
                    message = "Feature to be coming in the Future\n Select Again."
                    let title = "Feature Not Available"
                    
                    // Create the action.
                    let okAction = UIAlertAction(title: "Okay",
                        style: .Default,
                        handler: nil)
                    
                    let alertController =
                    UIAlertController(title: title,
                        message: message,
                        preferredStyle: .Alert)
                        alertController.addAction(okAction)
                    presentViewController(alertController,
                        animated: true,
                        completion: nil)
                }
                
                
            }
        }
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue){
        
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
    
    func compAlert(message:String){
        let title = "Start you Game"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        
        // Create the action.
        let cancelAction = UIAlertAction(title: "Cancel", style: .Destructive) { action in
            let cancelController = UIAlertController(title: "No Problem", message: "Select again.", preferredStyle: .Alert)
            let okayAction = UIAlertAction(title: "Okay", style: .Default, handler: nil)
            cancelController.addAction(okayAction)
            self.presentViewController(cancelController, animated: true, completion: nil)
        }
        let confirmAction = UIAlertAction(title: "Confirm", style: .Default) { action in
            //let dateString = dateFormat.stringFromDate(date)
            let okayController = UIAlertController(title: "Welcome!", message: "Your Game Will begin shortly.", preferredStyle: .Alert)
            let okayAction = UIAlertAction(title: "Okay", style: .Default, handler: nil)
            okayController.addAction(okayAction)
            self.presentViewController(okayController, animated: false, completion: nil)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        presentViewController(alertController, animated: true, completion: nil)
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