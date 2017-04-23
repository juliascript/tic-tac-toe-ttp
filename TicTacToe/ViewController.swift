//
//  ViewController.swift
//  TicTacToe
//
//  Created by Julia on 11/2/16.
//  Copyright © 2016 Make school. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FieldViewDelegate {
    
    
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var turnLabel: UILabel!
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
        var yPosition = 100
        let fieldWidth = Int(screenWidth / 3)
        let fieldHeight = Int(boardHeight / 3)
        
        for i in 0...2 {
            for j in 0...2 {
                let fieldView: FieldView = FieldView(frame: CGRect(x: xPosition, y: yPosition, width: fieldWidth, height: fieldHeight))
                
                fieldView.delegate = self
                fieldView.coordinate = CGPoint(x: i, y: j)
                fieldView.text = board.board[i][j].rawValue
                fieldView.textAlignment = NSTextAlignment.center
                fieldView.textColor = UIColor.white
                fieldView.font = UIFont(name: "Avenir Next", size: 40)
                fieldView.layer.borderWidth = 1
                fieldView.layer.borderColor = UIColor.white.cgColor
                fieldView.isUserInteractionEnabled = true
                
                boardView.addSubview(fieldView)
                xPosition += fieldWidth
            }
            xPosition = 0
            yPosition += fieldHeight + 1
        }
        
        self.view.addSubview(boardView)
        restartButton.backgroundColor = .clear
        restartButton.layer.borderWidth = 1
        restartButton.layer.borderColor = UIColor.white.cgColor
        restartButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 50, bottom: 20, right: 50)
        
        turnLabel.text = "X turn"
    }
    
    func endGameAnimation(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = NSNumber(value: 2.0)
        animation.duration = 0.5
        animation.repeatCount = 1.0
        animation.autoreverses = true
        turnLabel.layer.add(animation, forKey: nil)
    }
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        board.resetBoard()
        
        for subview in boardView.subviews{
            let subv: UILabel = subview as! UILabel
            subv.text = State.empty.rawValue
            subv.isUserInteractionEnabled = true
        }
        boardView.isUserInteractionEnabled = true
        switch turn {
        case .O:
            turnLabel.text = "O turn"
        case .X:
            turnLabel.text = "X turn"
        }
    }

    
    
    func fieldViewTapped(sender: FieldView){
        print(sender.coordinate)
        let row = Int(sender.coordinate.x)
        let column = Int(sender.coordinate.y)
        
        // update view 
        if row == 0 {
            reloadBoard(index: column)
        } else if row == 1 {
            reloadBoard(index: column + 3)
        } else if row == 2 {
            reloadBoard(index: column + 6)
        }
        
        // update data model
        switch turn {
        case .O:
            board.setValueAt(row, column, State.O)
            self.turn = Turn.X
            turnLabel.text = "X turn"
        case .X:
            board.setValueAt(row, column, State.X)
            self.turn = Turn.O
            turnLabel.text = "O turn"
        }
        
        // check board for winner
        let someoneWon = isWinner(board: board)
        if someoneWon {
            var winner = ""
            switch turn{
            case .O:
                winner = "X"
            case .X:
                winner = "O"
            }
            print("\(winner) won!")
            turnLabel.text = "\(winner) won!"
            endGameAnimation()
            boardView.isUserInteractionEnabled = false
        }
        
        // check for tie game
        let tieGame = board.isFull()
        if tieGame {
            turnLabel.text = "Tie game!"
            endGameAnimation()
            boardView.isUserInteractionEnabled = false
        }
    }
    
    func reloadBoard(index: Int) {
        let subview: UILabel = boardView.subviews[index] as! UILabel
        switch turn {
        case .O:
            subview.text = Turn.O.rawValue
        case .X:
            subview.text = Turn.X.rawValue
        }
        subview.isUserInteractionEnabled = false
    }
    
    func isWinner(board: Board) -> Bool{
        print(board.board)
        
        // can do a Bool enum for X and a Bool enum for O
        
        // - X -
        // - X -
        // - X -
        if board.board[1][1].rawValue == board.board[0][1].rawValue && board.board[0][1].rawValue != "-" && board.board[1][1].rawValue == board.board[2][1].rawValue {
                print("1")
                return true
            
        // - - X
        // - X -
        // X - -
        } else if board.board[1][1].rawValue == board.board[0][2].rawValue && board.board[0][2].rawValue != "-" && board.board[1][1].rawValue == board.board[2][0].rawValue {
                print("2")
                return true
            
        // - - -
        // X X X
        // - - -
        } else if board.board[1][1].rawValue == board.board[1][2].rawValue && board.board[1][2].rawValue != "-" && board.board[1][1].rawValue == board.board[1][0].rawValue {
                print("3")
                return true
            
        // X - -
        // - X -
        // - - X
        } else if board.board[1][1].rawValue == board.board[2][2].rawValue && board.board[2][2].rawValue != "-" && board.board[1][1].rawValue == board.board[0][0].rawValue {
                print("4")
                return true
            
        // X - -
        // X - -
        // X - -
        } else if board.board[1][0].rawValue == board.board[0][0].rawValue && board.board[0][0].rawValue != "-" && board.board[1][0].rawValue == board.board[2][0].rawValue {
                print("5")
                return true
            
        // - - X
        // - - X
        // - - X
        } else if board.board[1][2].rawValue == board.board[0][2].rawValue && board.board[0][2].rawValue != "-" && board.board[1][2].rawValue == board.board[2][2].rawValue {
                print("6")
                return true
            
        // X X X
        // - - -
        // - - -
        } else if board.board[0][1].rawValue == board.board[0][0].rawValue && board.board[0][0].rawValue != "-" && board.board[0][1].rawValue == board.board[0][2].rawValue {
                print("7")
                return true
            
        // - - -
        // - - -
        // X X X
        } else if board.board[2][1].rawValue == board.board[2][0].rawValue && board.board[2][0].rawValue != "-" && board.board[2][1].rawValue == board.board[2][2].rawValue {
                print("8")
                return true
            
        }
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

