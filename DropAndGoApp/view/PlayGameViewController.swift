//
//  PlayGameViewController.swift
//  DropAndGoApp
//
//  Created by Kayle Drucker on 2/23/16.
//  Copyright © 2016 D and D Software. All rights reserved.
//

import UIKit

class PlayGameViewController: UIViewController {

    var board = [[Int]]()
    let BOARD_SIZE_X = 9
    let BOARD_SIZE_Y = 9
    let SCORING_X = 2
    let SCORING_Y = 2
    let SCORING_Z = 1 //number of points awarded for diagonal
    
    func makeMove(player: Int, and moveColumn: Int) -> Bool {
        if(player < 1 || player > 2 || moveColumn < 1 || moveColumn > BOARD_SIZE_X){
            //errorMessage = ""
            
        }
        return true
    }
    
    struct CGRect {
        var origin: CGPoint
        var size: CGSize
        init(origin: CGPoint, size: CGSize){
            self.origin = origin
            self.size = size
        }
       
    }
    

    @IBAction func switchToMainMenu(sender: UIBarButtonItem) {
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let target = segue.destinationViewController as? TutorialViewController{
            target.from = "PlayGameViewController"
            /*
            target.message = "From YellowViewController"
            if let text = textField.text {
                target.message += "\nMessage: \(text)"
            }
*/
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
