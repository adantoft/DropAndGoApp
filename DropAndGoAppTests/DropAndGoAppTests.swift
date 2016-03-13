//
//  DropAndGoAppTests.swift
//  DropAndGoAppTests
//
//  Created by Alex Dantoft on 2/21/16.
//  Copyright © 2016 D and D Software. All rights reserved.
//

import XCTest
@testable import DropAndGoApp

class DropAndGoAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testBoardSetUp() {
        let board = Board.init()
        let p1 = 1
        let p2 = 2
        
        XCTAssertTrue(board.hasAvailableMoves(), "blank board must have moves available")
        XCTAssertEqual(board.getBoardLength(), 9, "default is 9")
        XCTAssertEqual(board.getPlayerScore(p1), 0, "at start, should be zero")
        XCTAssertEqual(board.getPlayerScore(p2), 0, "at start, should be zero")
        
        var arr = Array(count: 9, repeatedValue: Array(count: 9, repeatedValue: 0))
        
        for var i = 0; i < 9; i++ { //fill board full of moves
            for var j = 0; j < 9; j++ {
                arr[i][j] = Int(arc4random_uniform(2))+1
            }
        }
        board.setBoard(arr)
        XCTAssertEqual(board.getStateArrayCopy(), arr, "should be arrays of equal values")
        XCTAssertFalse(board.hasAvailableMoves(), "board should be full")
        XCTAssertNotEqual(board.getPlayerScore(p1), 0, "there should be plenty of points on the board") //NOTE: due to randomness there is a small chance this would fail naturally
        XCTAssertNotEqual(board.getPlayerScore(p2), 0, "there should be plenty of points on the board")
        XCTAssertFalse(try! board.makeMove(p1, moveColumn: 1), "shold not be able to make a move")
        
    }
    
    func testBoardMovesAndScoring() {
        let board = Board.init()
        let p1 = 1
        let p2 = 2
        
        XCTAssertEqual(board.getPlayerScore(p1), 0, "at start, should be zero")
        XCTAssertEqual(board.getPlayerScore(p2), 0, "at start, should be zero")
        XCTAssertEqual(board.getBoardLength(), 9, "default is 9")
        
        //**TESTING ILLIGAL MOVES**
        
        do {
            try board.makeMove(3, moveColumn: 1)
            XCTFail("this should not be reached")
        } catch Board.Errors.OutOfBounds {
        } catch{
            XCTFail("this should not be reached")
        }
        do {
            try board.makeMove(3, moveColumn: 0)
            XCTFail("this should not be reached")
        } catch Board.Errors.OutOfBounds {
        } catch{
            XCTFail("this should not be reached")
        }
        do {
            try board.makeMove(3, moveColumn: board.getBoardLength()+1)
            XCTFail("this should not be reached")
        } catch Board.Errors.OutOfBounds {
        } catch{
            XCTFail("this should not be reached")
        }
        
        //**SCORING**
        
        XCTAssertTrue(try! board.makeMove(p1, moveColumn: 4))
        XCTAssertTrue(try! board.makeMove(p1, moveColumn: 5))
        XCTAssertEqual(board.getPlayerScore(p1), 2)
        XCTAssertTrue(try! board.makeMove(p1, moveColumn: 4))
        XCTAssertEqual(board.getPlayerScore(p1), 5)
        XCTAssertTrue(try! board.makeMove(p1, moveColumn: 5))
        XCTAssertEqual(board.getPlayerScore(p1), 10)
        XCTAssertTrue(try! board.makeMove(p2, moveColumn: 4))
        XCTAssertTrue(try! board.makeMove(p2, moveColumn: 5))
        XCTAssertEqual(board.getPlayerScore(p1), 10)
        XCTAssertEqual(board.getPlayerScore(p2), 2)
        XCTAssertTrue(try! board.makeMove(p1, moveColumn: 4))
        XCTAssertTrue(try! board.makeMove(p1, moveColumn: 4))
        XCTAssertTrue(try! board.makeMove(p1, moveColumn: 4))
        XCTAssertTrue(try! board.makeMove(p1, moveColumn: 4))
        XCTAssertTrue(try! board.makeMove(p1, moveColumn: 4))
        XCTAssertTrue(try! board.makeMove(p1, moveColumn: 4))
        XCTAssertFalse(try! board.makeMove(p1, moveColumn: 4), "column 4 should be full, not longer able to make moves")
        
    }
    
    func testNodeSetUp() {
        let board = Board.init()
        let p1 = 1
        let p2 = 2
        let node = Node.init(board: board, action: 0, depth: 0)
        let node2 = Node.init(board: board, action: 0, depth: 0)
        
        XCTAssertEqual(node.getBoard().getStateArrayCopy(), board.getStateArrayCopy())
        XCTAssertEqual(node.getAction(),0)
        XCTAssertEqual(node.getDepth(),0)
        XCTAssertNil(node.parentNode)
        
        do { //tests getting parent when no parent is set; should throw error
            try node.getParent()
            XCTFail("this should not be reached")
        } catch Node.Errors.NotSetYet {
        } catch{
            XCTFail("this should not be reached")
        }
        node.setParent(node2) //set parrent
        
        do { //test getting parent again, should not throw error
            try node.getParent()
        } catch Node.Errors.NotSetYet {
            XCTFail("this should not be reached")
        } catch{
            XCTFail("this should not be reached")
        }
        
        XCTAssertFalse(node.hasChildren())
        
        do { //test getting eval value, should throw error
            try node.getEvalValue()
            XCTFail("this should not be reached")
        } catch Node.Errors.NotSetYet {
        } catch{
            XCTFail("this should not be reached")
        }
        node.setEvalValue(1)
        
        do {//test getting eval value again, should not throw error
            let tmp = try node.getEvalValue()
            XCTAssertEqual(tmp, 1)
        } catch Node.Errors.NotSetYet {
            XCTFail("this should not be reached")
        } catch{
            XCTFail("this should not be reached")
        }
        
        XCTAssertNil(node.getChildNodes())
        
        let successStates = node.getSuccessorStates(p1)
        
        XCTAssertTrue(node.hasChildren())
        XCTAssertEqual(successStates.count, 9, "Blank game board should have 9 states")
        XCTAssertEqual(node.getChildNodes()?.count, 9, "Blank game board should have 9 states")
        
        XCTAssertEqual(board.getPlayerScore(p1), 0, "board should have not changed")
        XCTAssertEqual(board.getPlayerScore(p2), 0, "board should have not changed")
        
        
        let board2 = Board.init()
        let node3 = Node.init(board: board2, action: 0, depth: 0)
        
        for _ in 1...9{ //makes 9 moves filling column 1 completely
            XCTAssertTrue(try! board2.makeMove(p1, moveColumn: 1))
        }
        
        XCTAssertEqual(board2.getPlayerScore(p1), 16)
        let successStates2 = node3.getSuccessorStates(p1)
        
        XCTAssertTrue(node3.hasChildren())
        XCTAssertEqual(successStates2.count, 8, "board should have only 8 possible moves")
        
    }
    
    
    
    
    
    //    func testPerformanceExample() {
    //        // This is an example of a performance test case.
    //        self.measureBlock {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
    
}
