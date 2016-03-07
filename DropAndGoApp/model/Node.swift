//
//  Node.swift
//  DropAndGoApp
//
//  Created by Alex Dantoft on 2/27/16.
//  Copyright © 2016 D and D Software. All rights reserved.
//

import Foundation

//TODO: Break below code into sections
//TODO: covert from Java to Swift


class Node {
    
    var board: Board
    var parentNode: Node
    var childNodes: Array<Node>
    var depth: Int
    var action: Int
    var evalValue: Int?  //this is the value of the board based on the evaluation function set in the AI
    
    enum Errors: ErrorType {
        case NotSetYet
    }
    
    /**
     * Node is primarily used to keep track of board states and relationships between boards
     *
     * @param parentNode the parent of this Node (what the board was before this board state)
     * @param board      the board that this node contains
     * @param action     the action made to get to this board
     * @param depth      number of layers from the root node
     */
    init(parentNode: Node?, board: Board, action: Int, depth: Int) {
        self.parentNode = parentNode! //TODO: Remove from init and have set later
        self.board = board
        self.action = action
        self.depth = depth
        self.childNodes = []
    }
    
    func getBoard() -> Board {
        return board;
    }
    func getAction() -> Int {
        return action;
    }
    
    func getParent() -> Node {
        return parentNode;
    }
    
    func getDepth() -> Int {
        return depth;
    }
    
    /**
     * Determines if this mode has children
     *
     * @return true if node has children
     */
    func hasChildren() -> Bool{
        if (childNodes.isEmpty) {
            return false;
        } else {
            return true;
        }
    }
    
    /**
     * Provides the value of the evaluation as described in the AI
     *
     * @return Integer value of board
     */
    func getEvalValue() throws -> Int {
        if let eValue: Int = evalValue {
            return eValue;
        } else {
            throw Errors.NotSetYet
        }
        
    }
    
    /**
     * Sets the value of the evaluation as described in the AI
     *
     * @param evalValue value to be set
     */
    func setEvalValue(evalValue: Int) {
        self.evalValue = evalValue;
    }
    
    /**
     * @return List of child nodes
     */
    func getChildNodes() -> Array<Node>? { //TODO: Make sure optional value is handled correctly
        
        if (childNodes.isEmpty) {
            return nil;
        } else {
            return childNodes; //does not check for visiting a state since all states will be a new state (can't undo moves)
        }
        
    }
    
    /**
     * @param player whose success states to get
     * @return list of child nodes (possible moves from current board for player)
     */
    func getSuccessorStates(player: Int) -> Array<Node> { //returns list of successor states (children of this node)
        if (!hasChildren()) {
            makeChildren(player); //makes children if they do not exist
        }
        return childNodes; //does not check for visiting a state since all states will be a new state (can't undo moves)
    }
    
    /**
     * Makes children nodes (available board states -> possible moves) for player
     *
     * @param player whose success states to calculate
     */
    func makeChildren(player: Int) { //makes children (all possible moves) from current board state
        //illegal moves cause yield null child nodes
        
        var tmpBoard: Board
        
        for var i = 1; i < board.getBoardLength() + 1; i++ {
            
            tmpBoard = board //TODO: needs to provide a copy of the board... Clone??
            
            do {
                try tmpBoard.makeMove(player, moveColumn: i)  //tries to make move and tests success
                childNodes.append(Node(parentNode: self, board: tmpBoard, action: i, depth: depth + 1)) //move successful; makes new node
            } catch Board.Errors.OutOfBounds {
                print("Move is not valid on board")
            } catch {
                print("Unknown ERRROR!")
            }
            
        }
    }
    
    
    
    
    
}



/*
JAVA CODE:

NOT SURE IF BELOW CODE IS NEEDED IN SWIFT

@Override
public String toString() {
return "State: " + board + " Action: " + action + " Eval: " + evalValue;



*/