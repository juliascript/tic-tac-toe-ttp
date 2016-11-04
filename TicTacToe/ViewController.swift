//
//  ViewController.swift
//  TicTacToe
//
//  Created by Julia on 11/2/16.
//  Copyright © 2016 Make school. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FieldViewDelegate {
    
    var boardView: BoardView = BoardView()
    var board: Board = Board()
    var turn: Turn = Turn.X

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let screenWidth = self.view.frame.width
        let boardHeight = self.view.frame.height / 2
        
        // create fields within board view and set coordinate
        boardView = BoardView(frame: CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: screenWidth, height: boardHeight))
        
        var xPosition = 0
        var yPosition = 0
        let fieldWidth = Int(screenWidth / 3)
        let fieldHeight = Int(boardHeight / 3)
        
        for i in 0...2 {
            for j in 0...2 {
                let fieldView: FieldView = FieldView(frame: CGRect(x: xPosition, y: yPosition, width: fieldWidth, height: fieldHeight))
                
                fieldView.fieldDelegate = self
                fieldView.coordinate = CGPoint(x: i, y: j)
                fieldView.text = board.board[i][j].rawValue
                fieldView.isUserInteractionEnabled = true
                
                boardView.addSubview(fieldView)
                xPosition += fieldWidth
            }
            xPosition = 0
            yPosition += fieldHeight
        }
        
        self.view.addSubview(boardView)
    }
    
    func fieldViewTapped(sender: FieldView){
        let row = Int(sender.coordinate.x)
        let column = Int(sender.coordinate.y)
        switch turn {
        case .O:
            board.setValueAt(row, column, State.O)
            self.turn = Turn.X
        case .X:
            board.setValueAt(row, column, State.X)
            self.turn = Turn.O
        }
        // check board for winner
        let someoneWon = isWinner(board: board)
        if someoneWon {
            boardView.isUserInteractionEnabled = false
            // change label to "\(player) won!"
        }
    }
    
    func isWinner(board: Board) -> Bool{
        print(board.board)
        
        
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

