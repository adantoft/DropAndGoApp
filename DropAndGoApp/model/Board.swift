//
//  Board.swift
//  DropAndGoApp
//
//  Created by Alex Dantoft on 2/27/16.
//  Copyright © 2016 D and D Software. All rights reserved.
//

import Foundation

class Board {
    
    var board: [[Int]]
    var hashString: String = ""
    let BOARD_SIZE_X: Int = 9; //NOTE: Code currently assumes board is always square
    let BOARD_SIZE_Y: Int = 9; //need to add X and Y lengths to all methods below to handle non-square
    let SCORING_X: Int = 2; //number of points awarded for horizontal points touching
    let SCORING_Y: Int = 2; //number of points awarded for vertical points touching
    let SCORING_Z: Int = 1; //number of points awarded for diagonal points touching
    
    /**
    * BOARD PIECE DEFINITIONS:
    * 0 == open spot (no player has placed piece here)
    * 1 == player 1 has placed a piece
    * 2 == player 2 has placed a piece
    * [number] == player [number] has placed a piece; could do more than 2 players :-)
    */
    init() { //TODO add ability to make NxN, non-square board
        self.board = Array(count: BOARD_SIZE_X, repeatedValue: Array(count: BOARD_SIZE_Y, repeatedValue: 0));
    }
    
    enum Errors: ErrorType {
        case OutOfBounds
    }
    
    /**
     * Places move on the board
     *
     * @param player     player number 1 to x
     * @param moveColumn column in which move is being made 1 to board horizontal length
     * @return true if move successful, false if move failed (column is full)
     */
    func makeMove(player: Int, moveColumn: Int) throws -> Bool {
        
        if (player < 1 || //must be either player 1 or 2
            player > 2 ||
            moveColumn < 1 || //move must fit on board
            moveColumn > BOARD_SIZE_X
            ) {
                throw Errors.OutOfBounds
        }
        
        do {
            self.board[moveColumn - 1][try getNextRow(moveColumn) - 1] = player;
        } catch Errors.OutOfBounds {
            return false;
        }
        return true;
    }
    
    
    /**
     * Provides the next available row in a column (1 spot above the highest game piece)
     *
     * @param col Column to search for next available spot (1 to board length)
     * @return row of free spot
     */
    
    func getNextRow(col: Int) throws -> Int{
        var i: Int = 0;
        
        while (i < BOARD_SIZE_Y) { //loops to find next available spot (denoted by zero)
            if (board[col - 1][i] == 0) {
                return i + 1;
            }
            i++;
        }
        throw Errors.OutOfBounds //no free spot in column
    }
    
    /**
     * Provides a copy of int array
     *
     * @return 2 dimensional int array
     */
    
    func getStateArrayCopy() -> [[Int]] { //creates copy of int array
        
        //TODO: since arrays are all pass by value, likely do not need to iterate through board
        
        var arrCopy: [[Int]] = Array(count: BOARD_SIZE_X, repeatedValue: Array(count: BOARD_SIZE_Y, repeatedValue: 0));
        
        for var i = 0; i < board.count; i++ {
            for var j = 0; j < board[0].count; j++ {
                arrCopy[i][j] = board[i][j];
            }
        }
        return arrCopy;
    }
    
    /**
     * Gets size of board
     *
     * @return int of board length
     */
    func getBoardLength() -> Int {
        return BOARD_SIZE_X;
    }
    
    
    
    /**
     * Sets board to new int array (new pieces played)
     *
     * @param arr new 2d int array
     */
    func setBoard(arr: [[Int]] ) {
        self.board = arr;
    }
    
    
    /**
     * Determines if there are still open moves on the board
     *
     * @return true if there are moves available
     */
    func hasAvailableMoves() -> Bool {
        for var i = board.count - 1; i >= 0; i-- {
            if (board[i][board.count - 1] == 0) {
                return true;
            }
        }
        return false;
    }
    
    
    /**
     * Calculates and returns score of player
     *
     * @param player player in which to evaluate score
     * @return player score
     */
    
    func getPlayerScore(player: Int) -> Int {
        var pointsX: Int = 0;
        var pointsY: Int = 0;
        var pointsZ: Int = 0;
        var endOfBoardX: Bool = false;
        
        //TODO: OPTIONAL: if reach empty spot on board, column can stop being evaluated to improve code performance
        //TODO: OPTIONAL: also could make score just evaluate the most recent move and add to previous score - even faster
        
        for var i = 0; i < board.count; i++ {//vertical score evaluation
            if (i == board.count - 1) {
                endOfBoardX = true;
            }
            for var j = 0; j < board[0].count; j++ {
                if (board[i][j] == player) {  //tests if the current spot is player piece
                    if (j < board.count - 1 && board[i][j + 1] == player) {  //vertical evaluation - is up player piece?
                        pointsY += SCORING_Y;
                    }
                    if (!endOfBoardX) { //prevents evaluating off the horizontal board
                        if (board[i + 1][j] == player) {  //horizontal evaluation - is right player piece?
                            pointsX += SCORING_X;
                        }
                        if (j < board.count - 1 && board[i + 1][j + 1] == player) {  //diagonal evaluation - is right and up player piece?
                            pointsZ += SCORING_Z;
                        }
                        if (j > 0 && board[i + 1][j - 1] == player) {  //diagonal evaluation - is right and down player piece?
                            pointsZ += SCORING_Z;
                        }
                    }
                }
            }
        }
        return pointsX + pointsY + pointsZ;
    }
    
    
    /**
     * Calculates hashcode for board
     *
     * @return hashcode int
     */
     func hashCode() -> Int {
        for var i = 0; i < board.count; i++ {//needs to be recalculated after every move as the board is mutable
            for var j = 0; j < board[0].count; j++ {
                hashString = hashString + String(board[i][j]);
            }
        }
        return hashString.hashValue;
    }
    
    
    /**
     * Provides string of int of all pieces on board
     *
     * @return string of ints
     */
    func toString() -> String {
        hashCode();
        return hashString;
    }
    
}

/*
JAVA CODE:

public class Board {

THE BELOW FUNCTION MIGHT NOT BE NEEDED IN SWIFT

/**
* Tests if board equals another board
*
* @param obj other board
* @return true if equal
*/
@Override
public boolean equals(Object obj) {
if (obj == this) {
return true;
}
if (obj == null || obj.getClass() != this.getClass()) {
return false;
}
return this.hashCode() == obj.hashCode();
}



THE BELOW FUNCTION MIGHT NOT BE NEEDED IN SWIFT AS ARRAYLIST IS JAVA SPECIFIC

/**
* Provides a copy of int array form of an ArrayList
*
* @return 2 dimensional ArrayList
*/
public List<List<Integer>> getStateArrayListCopy() {  //creates copy of int array in ArrayList form
List<List<Integer>> arrCopy = new ArrayList<>();
for (int i = 0; i < board.length; i++) {
for (int j = 0; j < board[0].length; j++) {
arrCopy.get(i).add(board[i][j]);
}
}
return arrCopy;
}


}

THE BELOW FUNCTION MIGHT NOT BE NEEDED SINCE ARRAYS ARE VALUE TYPE

/**
* Provides copy of the board
*
* @return board copy
*/
@Override
public Board clone() {
Board cloneBoard = new Board();
cloneBoard.setBoard(getStateArrayCopy());
return cloneBoard;
}














*/