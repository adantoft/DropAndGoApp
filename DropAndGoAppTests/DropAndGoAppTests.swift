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
    
    func testBoardSetup() {
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
    
    func testBoardScoring() {
        
             //        var arr = [[0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0], [2, 0, 0, 0, 0, 0, 0, 0, 0], [1, 2, 0, 0, 0, 0, 0, 0, 0], [1, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0]]
        //would be good to add some scoring tests here...
    }
    
    
    
    
    
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
