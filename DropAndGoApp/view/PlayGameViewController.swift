//
//  PlayGameViewController.swift
//  DropAndGoApp
//
//  Created by Kayle Drucker on 2/23/16.
//  Copyright © 2016 D and D Software. All rights reserved.
//

import UIKit

class PlayGameViewController: UIViewController {

    @IBOutlet weak var player1Display: UILabel!
    
    @IBOutlet weak var player2Display: UILabel!
    var board: Board?
    var node: Node?
    var ai: AI?
    var player1 = ""
    var player2 = ""
    var objects: [UIButton] = []
    
    

    @IBAction func switchToMainMenu(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawBoard()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        player1Display.text = player1 + ": 0"
        player2Display.text = player2 + ": 0"
       
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
    
    func drawBoard() {
        let numCols = 9
        let numRows = 9
        var xOffSet: CGFloat = 26
        var yOffSet: CGFloat = 96
        var row = 0
        var col = 0
        
        while(col < numRows) {
        repeat {
            let button = UIButton()
                button.backgroundColor = UIColor.blueColor()
                button.frame = CGRect(x: xOffSet, y: yOffSet, width: 24, height: 24)
                view.addSubview(button)
                objects.append(button)
                xOffSet += 26
                row++
        } while row < numRows
        yOffSet += 26
        xOffSet = 26
        row = 0
        col++
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
