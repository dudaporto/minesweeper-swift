//
//  Board.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import Foundation

class Board {
    let currentDifficulty: Game.Difficulty
    var board: [[BoardSquare]]
    
    init(difficulty: Game.Difficulty) {
        currentDifficulty = difficulty
        board = [[BoardSquare]](repeating: [BoardSquare](repeating: BoardSquare(),
                                                         count: difficulty.dimention), count: difficulty.dimention)
    }
    
    private func generateBoardValues(initialSquarePosition: Position) {
        setBombs(initialSquarePosition)
        
        for i in 0..<currentDifficulty.dimention {
            for j in 0..<currentDifficulty.dimention {
                let currentPosition = Position(lin: i, col: j)
                
                guard !isBomb(position: currentPosition) else {
                    break
                }
                
                board[i][j].value = calculateNumberOfBombs(arround: currentPosition)
            }
        }
    }
    
    private func setBombs(_ initialSquarePosition: Position) {
        var bombsCount = 0
        
        while bombsCount < currentDifficulty.numberOfBombs {
            let lin = Int.random(in: 0..<currentDifficulty.dimention)
            let col = Int.random(in: 0..<currentDifficulty.dimention)
            
            let position = Position(lin: lin, col: col)
            
            if position != initialSquarePosition {
                board[lin][col].value = -1
                bombsCount += 1
            }
        }
    }
    
    private func calculateNumberOfBombs(arround position: Position) -> Int {
        var bombsArround = 0
        
        for i in -1...1 {
            for j in -1...1 {
                let lin = position.lin + i
                let col = position.col + j
                let currentPosition = Position(lin: lin, col: col)
                
                guard currentPosition.isValid(in: currentDifficulty.dimention) else {
                    break
                }
                
                if isBomb(position: currentPosition) {
                    bombsArround += 1
                }
            }
        }
        
        return bombsArround
    }
    
    private func isBomb(position: Position) -> Bool {
        return board[position.lin][position.col].isBomb
    }
    
    private func flag(position: Position) {
        board[position.lin][position.col].state = .flagged
    }
    
    private func reveal(position: Position) {
        board[position.lin][position.col].state = .revealed
    }
}

struct Position: Equatable {
    let lin: Int
    let col: Int
    
    static func == (lhs: Position, rhs: Position) -> Bool {
        return
            lhs.lin == rhs.lin && lhs.col == rhs.col
    }
    
    func isValid(in dimention: Int) -> Bool {
        return lin >= 0 &&
            lin < dimention &&
            col >= 0 &&
            col < dimention
    }
}

