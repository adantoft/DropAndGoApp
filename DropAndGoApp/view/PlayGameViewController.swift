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
    
    let board: Board = Board.init()
    var p1: Int = 1
    var p2: Int = 2
    var ai: AI!
    let aiDifficulty: Int = 2
    var moveCount: Int = 0; //keeps track of moves
    var moveLimit: Int = 0 //once this is reached gamestate is set to false
    var gameState: Bool = true; //game will loop turns until false
    var p1Name = ""
    var p2Name = ""
    var objects: [UILabel] = []
    
    var array = Array(count: 9, repeatedValue: Array(count: 9, repeatedValue: 0))
    
    
    @IBAction func switchToMainMenu(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (board.getBoardLength() % 2 == 0) { //if board has odd number of pieces, only 1 blank space means game over so both players have equal turns
            moveLimit = board.getBoardLength() * board.getBoardLength(); // even
        } else {
            moveLimit = board.getBoardLength() * board.getBoardLength() - 1; //odd
        }
        if p1Name == "" {
            p1Name = "Player"
        }
        player1Display.text = p1Name + ": 0"
        player2Display.text = p2Name + ": 0"        
        
        drawInitialBoard()
        ai = AI.init(board: board, playerNumber: p2, opponentPlayerNumber: p1, plyLevel: aiDifficulty, pruning: false)
    }
    
    func handleSingleTap(sender: UITapGestureRecognizer) {
        let tappedGraphic = sender.view!
        try! board.makeMove(p1, moveColumn: tappedGraphic.tag/10)
        reDrawBoard()
        player1Display.text = p1Name + ": " + String(board.getPlayerScore(p1))
        moveCount++
        if (!board.hasAvailableMoves() || moveCount == moveLimit) { //checks if there are available moves or if move limit is reached
            gameState = false;     // also will leave 1 spot open in odd by odd board length games to not give first player an extra move
        } else {
            
            //AI Makes a move
            try! board.makeMove(p2, moveColumn: ai.getMove())
            reDrawBoard()
            player2Display.text = p2Name + ": " + String(board.getPlayerScore(p2))
            moveCount++
            if (!board.hasAvailableMoves() || moveCount == moveLimit) { //checks if there are available moves or if move limit is reached
                gameState = false;     // also will leave 1 spot open in odd by odd board length games to not give first player an extra move
            }
        }
        
        if (!gameState) { //checks if game is over
            var message = ""
            var p1 = player1Display.text
            var p2 = player2Display.text
            var p1Score = p1?.componentsSeparatedByString(": ")
            var p2Score = p2?.componentsSeparatedByString(": ")
            var one = p1Score![1]
            var two = p2Score![1]
            if one < two {
                message = " \(p2Score![0]) is the WINNER!\n \(p1Score![0])=\(p1Score![1])\n \(p2Score![0])=\(p2Score![1]) "
                gameOverAlert(message)
            } else {
                message = " \(p1Score![0]) is the WINNER!\n \(p1Score![0])=\(p1Score![1])\n \(p2Score![0])=\(p2Score![1]) "
                gameOverAlert(message)
            }
        
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {

    }
    
    func gameOverAlert(message: String){
        let title = "Game Over!"
        
        // Create the action.
        let okAction = UIAlertAction(title: "Okay",
            style: .Default,
            handler: {(_) in self.performSegueWithIdentifier("unwindToMenu", sender: self)})
        
        let alertController =
        UIAlertController(title: title,
            message: message,
            preferredStyle: .Alert)
        alertController.addAction(okAction)
        presentViewController(alertController,
            animated: true,
            completion: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let target = segue.destinationViewController as? TutorialViewController{
            target.from = "PlayGameViewController"
        }
    }
    
    
    func drawInitialBoard() {
        
        let deviceType = UIDevice.currentDevice().modelName
        var m: UIDevice!
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        if deviceType.lowercaseString.rangeOfString("iphone 4") != nil {
            print("iPhone 4 or iphone 4s")
            x = 46
            y = 126
        }
        else if deviceType.lowercaseString.rangeOfString("iphone 5") != nil {
            print("iPhone 5 or iphone 5s")
            x = 46
            y = 146
        }
        else if deviceType.lowercaseString.rangeOfString("iphone 6") != nil {
            print("iPhone 6 Series")
            x = 76
            y = 166
        }
        
        let numCols = board.getBoardLength()
        let numRows = board.getBoardLength()
        var xOffSet: CGFloat = x
        var yOffSet: CGFloat = y
        
        for var i = 0; i < numRows; i++ {
            for var j = 0; j < numCols; j++ {
                let gameBoard = UILabel()
                gameBoard.backgroundColor = UIColor.blueColor()
                gameBoard.frame = CGRect(x: xOffSet, y: yOffSet, width: 24, height: 24)
                gameBoard.textColor = UIColor.whiteColor()
                gameBoard.textAlignment = .Center
                gameBoard.font = UIFont.systemFontOfSize(20)
                view.addSubview(gameBoard)
                objects.append(gameBoard)
                gameBoard.userInteractionEnabled = true
                let singleTapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
                gameBoard.addGestureRecognizer(singleTapRecognizer)
                gameBoard.tag = Int(String(i + 1) + String(numCols - j))! //concat j (col) and i (row) to form tag of (col row)
                yOffSet += 26
            }
            yOffSet = y
            xOffSet += 26
        }
        view.setNeedsDisplay()
    }
    
    func reDrawBoard() {
        
        for boardPiece in objects {
            let col = boardPiece.tag/10-1
            let row = boardPiece.tag%10-1
            
            if board.board[col][row] == 0 {
                //space is blank; do nothing
            } else if (board.board[col][row] ==  1){
                boardPiece.text = "X"
            } else if (board.board[col][row] == 2){
                boardPiece.text = "O"
            }
        }
        view.setNeedsDisplay()
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
