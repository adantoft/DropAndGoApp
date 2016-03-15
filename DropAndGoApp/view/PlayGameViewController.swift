//
//  PlayGameViewController.swift
//  DropAndGoApp
//
//  Created by Kayle Drucker on 2/23/16.
//  Copyright © 2016 D and D Software. All rights reserved.
//

import UIKit

class PlayGameViewController: UIViewController {
    
    @IBOutlet weak var singleTapLabel: UILabel!
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
    var player1 = ""
    var player2 = ""
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
        
        
        drawInitialBoard()
        ai = AI.init(board: board, playerNumber: p2, opponentPlayerNumber: p1, plyLevel: aiDifficulty, pruning: false)
    }
    
    func handleSingleTap(sender: UITapGestureRecognizer) {
        let tappedGraphic = sender.view!
//        tappedGraphic.backgroundColor = UIColor.grayColor()
//        print(String(tappedGraphic.tag/10 - 1) + String(tappedGraphic.tag%10 - 1))
        
        //Make player move
        try! board.makeMove(p1, moveColumn: tappedGraphic.tag/10)
        reDrawBoard()
        player1Display.text = String(board.getPlayerScore(p1))
        moveCount++
        
        //AI Makes a move
        try! board.makeMove(p2, moveColumn: ai.getMove())
        reDrawBoard()
        player2Display.text = String(board.getPlayerScore(p2))
        moveCount++
        
        if (!board.hasAvailableMoves() || moveCount == moveLimit) { //checks if there are available moves or if move limit is reached
            gameState = false;     // also will leave 1 spot open in odd by odd board length games to not give first player an extra move
            
            //TODO: CODE HERE ONCE GAME IS OVER!
        }
        
        
        
        //        for var x = 0; x < 81; x++ {
        //            tappedGraphic.backgroundColor = UIColor.grayColor()
        //        }
        //        let n = sender.numberOfTouches()
        //        var message = ""
        //        for i in 0 ..< n {
        //            message += " \(sender.locationOfTouch(i, inView: view))"
        //        }
        //        singleTapLabel.text = "Single tap at:" + message + "\nNumber of touches: \(n)"
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3 * NSEC_PER_SEC)),
        //            dispatch_get_main_queue()) { self.singleTapLabel.text = "No single tap detected" }
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
    
    func drawInitialBoard() {
        
        let numCols = board.getBoardLength()
        let numRows = board.getBoardLength()
        var xOffSet: CGFloat = 26
        var yOffSet: CGFloat = 96
        
        for var i = 0; i < numRows; i++ {
            for var j = 0; j < numCols; j++ {
                let gameBoard = UILabel()
                gameBoard.backgroundColor = UIColor.blueColor()
                gameBoard.frame = CGRect(x: xOffSet, y: yOffSet, width: 24, height: 24)
                gameBoard.textColor = UIColor.whiteColor()
                gameBoard.textAlignment = .Center
                gameBoard.font = UIFont.systemFontOfSize(20)
                view.addSubview(gameBoard)
                objects.append(gameBoard)  //TODO: Probably dont need
                gameBoard.userInteractionEnabled = true
                let singleTapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
                gameBoard.addGestureRecognizer(singleTapRecognizer)
                gameBoard.tag = Int(String(i + 1) + String(numCols - j))! //concat j (col) and i (row) to form tag of (col row)
                yOffSet += 26
            }
            yOffSet = 96
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
