//
//  Game.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import Foundation

protocol GameDelegate: NSObjectProtocol {
    func didWinGame()
    func didLoseGame()
}

class Game: NSObject {
    enum Difficulty: Int {
        case easy = 12
        case medium = 25
        case hard = 35
        
        var numberOfBombs: Int {
            rawValue
        }
        
        var boardSize: Board.Size {
            switch self {
            case .easy:
                return Board.Size(lines: 10, columns: 8)
            case .medium:
                return Board.Size(lines: 14, columns: 10)
            case .hard:
                return Board.Size(lines: 18, columns: 12)
            }
        }
        
        var totalCleanSquares: Int {
            return (boardSize.lines * boardSize.columns) - numberOfBombs
        }
    }
    
    weak var delegate: GameDelegate?
    
    var currentDifficulty: Difficulty
    var board: Board?
    private var squaresRevealed = 0
    
    init(difficulty: Difficulty = .medium) {
        board = nil
        currentDifficulty = difficulty
    }
    
    func didLose(boardView: BoardView) {
        delegate?.didLoseGame()
        boardView.performLoseAnimation()
    }
    
    func didWin(boardView: BoardView) {
        delegate?.didWinGame()
        boardView.performWinAnimation()
    }
    
    func reveal(from square: BoardSquareButton, at boardView: BoardView) {
        guard square.squareState == .unrevealed else {
            return
        }
        
        square.reveal()
        squaresRevealed += 1
        
        if square.value == 0 {
            //check the neighbors
            for i in -1...1 {
                for j in -1...1 {
                    let lin = square.positionInBoard!.lin + i
                    let col = square.positionInBoard!.col + j
                    let position = Position(lin: lin, col: col)
                    
                    if position.isValid(in: currentDifficulty.boardSize),
                        let square = boardView.getSquare(at: position) {
                        reveal(from: square, at: boardView)
                    }
                }
            }
        }
    }
}

extension Game: BoardViewDelegate {
    func boardViewDelegate(_ boardView: BoardView, didClickAtSquare square: BoardSquareButton) {
        if board == nil {
            board = Board(difficulty: currentDifficulty, initialSquarePosition: square.positionInBoard!)
            boardView.setValues(values: board!.values)
    
        }
        
        guard !square.isBomb else {
            didLose(boardView: boardView)
            return
        }
        
        reveal(from: square, at: boardView)
        
        if squaresRevealed == currentDifficulty.totalCleanSquares {
            didWin(boardView: boardView)
        }
    }
}
