//
//  Position.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 10/04/21.
//  Copyright © 2021 Maria Eduarda Porto. All rights reserved.
//

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


