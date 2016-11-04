//
//  Board.swift
//  TicTacToe
//
//  Created by Julia on 11/2/16.
//  Copyright © 2016 Make school. All rights reserved.
//

import UIKit

class Board: NSObject {
    
    var board: [[State]] =
        [
            [.empty,.empty,.empty],
            [.empty,.empty,.empty],
            [.empty,.empty,.empty]
        ]
    
    override init() {
        super.init()
        resetBoard()
        
    }
    
    func resetBoard() {
        board =
            [
                [.empty,.empty,.empty],
                [.empty,.empty,.empty],
                [.empty,.empty,.empty]
            ]
    }
    
    func setValueAt(_ row: Int, _ column: Int, _ state: State){
        board[row][column] = state
    }
    
}
