//
//  Board.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import Foundation

typealias BoardValues = [[Int]]

class Board {
    struct Size {
        //quantify of rows and columns in board
        
        let rows: Int
        let columns: Int
    }
    
    var values: BoardValues
    
    init(difficulty: Difficulty, initialSquarePosition: Position) {
        values = BoardEngine().generateBoardValues(
            boardSize: difficulty.boardSize,
            numberOfBombs: difficulty.numberOfBombs,
            initialSquarePosition: initialSquarePosition
        )
    }
}

