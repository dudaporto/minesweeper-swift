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
        //quantify of lines and columns in board
        
        let lines: Int
        let columns: Int
    }
    
    let currentDifficulty: Game.Difficulty
    var values: [[Int]]
    
    init(difficulty: Game.Difficulty, initialSquarePosition: Position) {
        currentDifficulty = difficulty
        values = [[Int]](repeating: [Int](repeating: 0, count: difficulty.boardSize.columns), count: difficulty.boardSize.lines)
        generateBoardValues(initialSquarePosition)
    }
    
    private func generateBoardValues(_ initialSquarePosition: Position) {
        setBombs(initialSquarePosition)

        for i in 0..<currentDifficulty.boardSize.lines {
            for j in 0..<currentDifficulty.boardSize.columns {
                let currentPosition = Position(lin: i, col: j)
                
                if !isBomb(position: currentPosition) {
                    values[i][j] = calculateNumberOfBombs(arround: currentPosition)
                }
            }
        }
    }
    
    private func setBombs(_ initialSquarePosition: Position) {
        var bombsCount = 0
        
        while bombsCount < currentDifficulty.numberOfBombs {
            let lin = Int.random(in: 0..<currentDifficulty.boardSize.lines)
            let col = Int.random(in: 0..<currentDifficulty.boardSize.columns)
            
            let position = Position(lin: lin, col: col)
            
            if position != initialSquarePosition {
                values[lin][col] = -1
                bombsCount += 1
            }
        }
    }
    
    private func calculateNumberOfBombs(arround position: Position) -> Int {
        var bombsArround = 0
        
        //check all neighbors in the matrix
        for i in -1...1 {
            for j in -1...1 {
                let lin = position.lin + i
                let col = position.col + j
                let currentPosition = Position(lin: lin, col: col)
                
                if currentPosition.isValid(in: currentDifficulty.boardSize), isBomb(position: currentPosition) {
                    bombsArround += 1
                }
            }
        }
        
        return bombsArround
    }
    
    private func isBomb(position: Position) -> Bool {
        return values[position.lin][position.col] == -1
    }
}

struct Position: Equatable {
    let lin: Int
    let col: Int
    
    static func == (lhs: Position, rhs: Position) -> Bool {
        return
            lhs.lin == rhs.lin && lhs.col == rhs.col
    }
    
    func isValid(in boardSize: Board.Size) -> Bool {
        return lin >= 0 &&
            lin < boardSize.lines &&
            col >= 0 &&
            col < boardSize.columns
    }
    
    static var zero: Position {
        return Position(lin: 0, col: 0)
    }
}

