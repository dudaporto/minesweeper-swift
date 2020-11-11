//
//  Board.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import Foundation

class Board {
    struct Size {
        //quantify of rows and columns in board
        
        let rows: Int
        let columns: Int
    }
    
    let currentDifficulty: Game.Difficulty
    var values: [[Int]]
    
    init(difficulty: Game.Difficulty, initialSquarePosition: Position) {
        currentDifficulty = difficulty
        values = [[Int]](repeating: [Int](repeating: 0, count: difficulty.boardSize.columns), count: difficulty.boardSize.rows)
        generateBoardValues(initialSquarePosition)
    }
    
    private func generateBoardValues(_ initialSquarePosition: Position) {
        setBombs(initialSquarePosition)

        for i in 0..<currentDifficulty.boardSize.rows {
            for j in 0..<currentDifficulty.boardSize.columns {
                let currentPosition = Position(row: i, col: j)
                
                if !isBomb(position: currentPosition) {
                    values[i][j] = calculateNumberOfBombs(arround: currentPosition)
                }
            }
        }
    }
    
    private func setBombs(_ initialSquarePosition: Position) {
        var bombsCount = 0
        
        while bombsCount < currentDifficulty.numberOfBombs {
            let row = Int.random(in: 0..<currentDifficulty.boardSize.rows)
            let col = Int.random(in: 0..<currentDifficulty.boardSize.columns)
            
            let position = Position(row: row, col: col)
            
            // prevents the bomb from being in the first clicked square or its neighbors
            if position != initialSquarePosition, !position.isNeighbor(of: initialSquarePosition) {
                values[row][col] = -1
                bombsCount += 1
            }
        }
    }
    
    private func calculateNumberOfBombs(arround position: Position) -> Int {
        var bombsArround = 0
        
        //check all neighbors in the matrix
        for i in -1...1 {
            for j in -1...1 {
                let row = position.row + i
                let col = position.col + j
                let currentPosition = Position(row: row, col: col)
                
                if currentPosition.isValid(in: currentDifficulty.boardSize), isBomb(position: currentPosition) {
                    bombsArround += 1
                }
            }
        }
        
        return bombsArround
    }
    
    private func isBomb(position: Position) -> Bool {
        return values[position.row][position.col] == -1
    }
}

struct Position: Equatable {
    let row: Int
    let col: Int
    
    static func == (lhs: Position, rhs: Position) -> Bool {
        return
            lhs.row == rhs.row && lhs.col == rhs.col
    }
    
    func isValid(in boardSize: Board.Size) -> Bool {
        return row >= 0 &&
            row < boardSize.rows &&
            col >= 0 &&
            col < boardSize.columns
    }
    
    func isNeighbor(of other: Position) -> Bool {
        for i in -1...1 {
            for j in -1...1 {
                let row = self.row + i
                let col = self.col + j
                
                if Position(row: row, col: col) == other {
                    return true
                }
            }
        }
        return false
    }
    
    static var zero: Position {
        return Position(row: 0, col: 0)
    }
}

