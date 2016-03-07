//
//  AI.swift
//  DropAndGoApp
//
//  Created by Alex Dantoft on 2/27/16.
//  Copyright © 2016 D and D Software. All rights reserved.
//

import Foundation

//TODO: Break below code into sections
//TODO: covert from Java to Swift


class AI {
    
    var board: Board
    var plyLevel: Int
    var playerNumber: Int
    var opponentPlayerNumber: Int
    var evaluateMax: Bool //used to determine if Node should be evaluated for Min or Max
    var pruning: Bool = false //pruning enabled/disabled
    
    init(board: Board, playerNumber: Int, opponentPlayerNumber: Int, plyLevel: Int, pruning: Bool) {
        self.board = board
        self.playerNumber = playerNumber
        self.opponentPlayerNumber = opponentPlayerNumber
        self.plyLevel = plyLevel
        self.pruning = pruning
        if (plyLevel % 2 == 0) {  //uses ply to determine if the base node will be Max or Min's time to evaluate
            evaluateMax = true; //ply is even
        } else {
            evaluateMax = false; //ply is odd
        }
    }
    
    
    
    
    func getMove() -> Int { //asks the AI for the next move
//            TODO: uncomment below lines once pruning is implemented
//        var alphaVal: Int = Int.min //sets alpha beta
//        var betaVal: Int = Int.max
        
        let rootNode: Node = Node(parentNode: nil, board: board, action: 0, depth: 0); //makes root node that has the current game board as a starting point
        var goodMoveNodes: Array<Node> = [] //list of nodes that are good moves
        if (pruning) {
            //TODO: Implement pruning tree
            //makePruningMoveTree(rootNode, playerNumber, alphaVal, betaVal, evaluateMax);  //run minmax with pruning
        }else {
//            TODO: uncomment below lines once functions are implemented
//            makeMoveTree(rootNode, player: playerNumber); //create minmax tree
//            evalMoveTree(rootNode, evaluateMax: evaluateMax); //bubble up the tree evaluating moves
        }
        
        

        
        for n in rootNode.getChildNodes()! {
            do {
                if (try n.getEvalValue() == rootNode.getEvalValue()) { //grabs nodes that are good moves
                    goodMoveNodes.append(n);
                }
            } catch Node.Errors.NotSetYet {
                print("Eval not set!!")
            } catch {
                print("Unknown ERRROR!")
            }
        }
        
        //        BELOW CAN LIKELY BE REMOVED; ONCE TESTING OF ABOVE CODE IS WORKING
        //        for n in rootNode.getChildNodes()! {
        //            if (try n.getEvalValue() == rootNode.getEvalValue()) { //grabs nodes that are good moves
        //                goodMoveNodes.append(n);
        //            }
        //        }
        
        var rand: Int
        if (goodMoveNodes.count == 0) { //there are no good moves (game over)
            rand = Int(arc4random_uniform(UInt32(rootNode.getChildNodes()!.count)))+1
            return rootNode.getChildNodes()![Int(rand)].getAction() //picks move at random
        } else if (goodMoveNodes.count > 1) {//there is more than 1 good move; pick 1 at random
            rand = Int(arc4random_uniform(UInt32(goodMoveNodes.count)))+1
            return goodMoveNodes[Int(rand)].getAction() //picks move at random
        } else {
            return goodMoveNodes[0].getAction() //there is only 1 good move
        }
        
    }
    
    
    
    
    
    
    
    
}





/*
JAVA CODE:


func makeMoveTree(node: Node, player: Int) { //recursive depth first function; creates node tree
if (node.getDepth() < plyLevel - 1) {
for (Node n : node.getSuccessorStates(player)) {
if (player == playerNumber) { //alternates players Min Max
makeMoveTree(n, opponentPlayerNumber);
} else {
makeMoveTree(n, playerNumber);
}
}
} else {
if (node.getSuccessorStates(player).size() != 0) {
for (Node n : node.getChildNodes()) {
n.setEvalValue(evaluate(n)); //set node evaluation values at base of tree
}
}
}
}

func evalMoveTree(node: Node, evaluateMax: Bool) { //recursive depth first function; finds base node
if (node.getDepth() < plyLevel - 1) {
if (node.hasChildren()) {
for (Node n : node.getChildNodes()) {
evalMoveTree(n, !evaluateMax);
}
}
node.setEvalValue(getMinMaxBubbleUp(node, evaluateMax)); //evaluate moves
} else {
node.setEvalValue(getMinMaxBubbleUp(node, evaluateMax)); //evaluate moves
}
}

private Integer getMinMaxBubbleUp(Node node, boolean evaluateMax) { //function to set node evaluation value based on its children's evaluations
if (node.getChildNodes() == null) {
return evaluate(node);
} else {
Integer evalValue = node.getChildNodes().get(0).getEvalValue();
for (Node n : node.getChildNodes()) {
assert n.getEvalValue() != null;
if (evaluateMax) {
evalValue = Math.max(n.getEvalValue(), evalValue); //evaluate for Max
} else {
evalValue = Math.min(n.getEvalValue(), evalValue); //evaluate for min
}
}
return evalValue;
}

}


private int evaluate(Node node) { //evaluation function. gets player score minus opponent player score

Integer eval = node.getBoard().getPlayerScore(playerNumber) - node.getBoard().getPlayerScore(opponentPlayerNumber);

if (!node.getBoard().hasAvailableMoves()) { //if there are no moves left (game over)
if (eval > 0) {
eval = Integer.MAX_VALUE; //max winning value
} else {
eval = Integer.MIN_VALUE; //min winning value
}
}

return eval;
}





// BELOW CODE IS ONLY NEEDED FOR PRUNING... MIGHT NOT BE NEEDED FOR PROTOTPE PROJECT

public void makePruningMoveTree(Node node, int player, Integer alphaVal, Integer betaVal, boolean evaluateMax) {
if (node.getDepth() < plyLevel - 1) {
for (Node n : node.getSuccessorStates(player)) {
if (player == playerNumber) {
makePruningMoveTree(n, opponentPlayerNumber, alphaVal, betaVal, evaluateMax);
} else {
makePruningMoveTree(n, playerNumber, alphaVal, betaVal, evaluateMax);
}

if (evaluateMax) { // MAX Node
n.setEvalValue(evaluate(n));
alphaVal = Math.max(n.getEvalValue(), alphaVal);
if (alphaVal >= betaVal) { //prune
alphaVal = Integer.MAX_VALUE;
break;
} else { //no prune
node.setEvalValue(n.getEvalValue());
betaVal = Math.min(node.getEvalValue(), betaVal);
}
} else { //MIN Node
n.setEvalValue(evaluate(n));
betaVal = Math.min(n.getEvalValue(), betaVal);
if (betaVal <= alphaVal) { //prune
betaVal = Integer.MAX_VALUE;
break;
} else { //no prune
node.setEvalValue(n.getEvalValue());
alphaVal = Math.max(node.getEvalValue(), alphaVal);
}
}
}
} else {
if (node.getSuccessorStates(player).size() != 0) {

if (evaluateMax) { // MAX Node
for (Node n : node.getChildNodes()) {
n.setEvalValue(evaluate(n));
alphaVal = Math.max(n.getEvalValue(), alphaVal);
if (alphaVal >= betaVal) { //prune
alphaVal = Integer.MAX_VALUE;
break;
} else { //no prune
node.setEvalValue(n.getEvalValue());
betaVal = Math.min(node.getEvalValue(), betaVal);
}

}

} else { //MIN Node
for (Node n : node.getChildNodes()) {
n.setEvalValue(evaluate(n));
betaVal = Math.min(n.getEvalValue(), betaVal);

if (betaVal <= alphaVal) { //prune
betaVal = Integer.MAX_VALUE;
break;
} else { //no prune
node.setEvalValue(n.getEvalValue());
alphaVal = Math.max(node.getEvalValue(), alphaVal);
}

}
}

}
}
}






}



*/

