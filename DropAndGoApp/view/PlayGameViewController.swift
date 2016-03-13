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
    var objects: [UILabel] = []
    var playerOne: [UILabel] = []
    var playerTwo = []
    var array = Array(count: 9, repeatedValue: Array(count: 9, repeatedValue: 0))
    
    
    
    @IBAction func switchToMainMenu(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawBoard()
        
        //        for n in objects {
        //            n.backgroundColor = UIColor.whiteColor()
        //        }

        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        player1Display.text = player1 + ": 0"
        player2Display.text = player2 + ": 0"
        
        for var i = 0; i < 81; i++ {
            if i % 2 == 0 {
                objects[i].backgroundColor = UIColor.redColor()
                objects[i].text = "*"
            }
            
        }
        
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
        
        for var i = 0; i < 9; i++ {
            for var j = 0; j < 9; j++ {
                array[i][j] = Int(arc4random_uniform(3))
            }
        }
        
        var numCols = 9
        var numRows = 9
        var xOffSet: CGFloat = 26
        var yOffSet: CGFloat = 96
        var row = 1
        var col = 1
        
        
        for var i = 0; i < 9; i++ {//vertical score evaluation
            for var j = 0; j < 9; j++ {
                let gameBoard = UILabel()
                gameBoard.backgroundColor = UIColor.blueColor()
                gameBoard.frame = CGRect(x: xOffSet, y: yOffSet, width: 24, height: 24)
                //var i = board!.board[row][col]
                var i = array[row - 1][col - 1]
                if i == 0 {
                    print("print = 0")
                } else if (i == 1){
                    gameBoard.textColor = UIColor.whiteColor()
                    gameBoard.textAlignment = .Center
                    gameBoard.font = UIFont.systemFontOfSize(20)
                    gameBoard.text = "X"
                    print("print = 1")
                } else if (i == 2){
                    gameBoard.textColor = UIColor.whiteColor()
                    gameBoard.textAlignment = .Center
                    gameBoard.font = UIFont.systemFontOfSize(20)
                    gameBoard.text = "O"
                }
                view.addSubview(gameBoard)
                objects.append(gameBoard)
                yOffSet += 26
            }
            yOffSet = 96
            xOffSet += 26
        }
        
        //        while(col-1 < numCols) {
        //            repeat {
        //                let gameBoard = UILabel()
        //                gameBoard.backgroundColor = UIColor.blueColor()
        //                gameBoard.frame = CGRect(x: xOffSet, y: yOffSet, width: 24, height: 24)
        //                //var i = board!.board[row][col]
        //                var i = array[row - 1][col - 1]
        //                if i == 0 {
        //                    print("print = 0")
        //                } else if (i == 1){
        //                    gameBoard.textColor = UIColor.whiteColor()
        //                    gameBoard.textAlignment = .Center
        //                    gameBoard.font = UIFont.systemFontOfSize(20)
        //                    gameBoard.text = "X"
        //                    print("print = 1")
        //                } else if (i == 2){
        //                    gameBoard.textColor = UIColor.whiteColor()
        //                    gameBoard.textAlignment = .Center
        //                    gameBoard.font = UIFont.systemFontOfSize(20)
        //                    gameBoard.text = "O"
        //                }
        //                view.addSubview(gameBoard)
        //                objects.append(gameBoard)
        //                xOffSet += 26
        //                row++
        //            } while row-1 < numRows
        //            yOffSet += 26
        //            xOffSet = 26
        //            row = 1
        //            col++
        //        }
        
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
