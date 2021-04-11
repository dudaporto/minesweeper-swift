//
//  BoardEngine.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 10/04/21.
//  Copyright © 2021 Maria Eduarda Porto. All rights reserved.
//

final class BoardEngine {
    func generateBoardValues(boardSize: Board.Size, numberOfBombs: Int, initialSquarePosition: Position) -> BoardValues {
        var boardValues = [[Int]](repeating: [Int](repeating: 0, count: boardSize.columns), count: boardSize.rows)
        boardValues = setBombs(
            boardSize: boardSize,
            initialSquarePosition: initialSquarePosition,
            numberOfBombs: numberOfBombs,
            values: boardValues
        )

        for i in 0..<boardSize.rows {
            for j in 0..<boardSize.columns {
                let currentPosition = Position(row: i, col: j)
                
                if !isBomb(values: boardValues, position: currentPosition) {
                    boardValues[i][j] = calculateNumberOfBombs(
                        arround: currentPosition,
                        boardSize: boardSize,
                        values: boardValues
                    )
                }
            }
        }
        
        return boardValues
    }
    
    private func setBombs(
        boardSize: Board.Size,
        initialSquarePosition: Position,
        numberOfBombs: Int,
        values: BoardValues
    ) -> BoardValues {
        var valuesWithBombs = values
        var bombsCount = 0
        
        while bombsCount < numberOfBombs {
            let row = Int.random(in: 0..<boardSize.rows)
            let col = Int.random(in: 0..<boardSize.columns)
            
            let position = Position(row: row, col: col)
            
            // prevents the bomb from being in the first clicked square or its neighbors
            if position != initialSquarePosition, !position.isNeighbor(of: initialSquarePosition) {
                valuesWithBombs[row][col] = -1
                bombsCount += 1
            }
        }
        
        return valuesWithBombs
    }
    
    private func calculateNumberOfBombs(arround position: Position, boardSize: Board.Size, values: BoardValues) -> Int {
        var bombsArround = 0
        
        //check all neighbors in the matrix
        for i in -1...1 {
            for j in -1...1 {
                let row = position.row + i
                let col = position.col + j
                let currentPosition = Position(row: row, col: col)
                
                if currentPosition.isValid(in: boardSize), isBomb(values: values, position: currentPosition) {
                    bombsArround += 1
                }
            }
        }
        
        return bombsArround
    }

    private func isBomb(values: BoardValues, position: Position) -> Bool {
        return values[position.row][position.col] == -1
    }
}
