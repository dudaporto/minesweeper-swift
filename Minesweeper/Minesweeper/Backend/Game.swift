//
//  Game.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import Foundation

final class Game: NSObject {
    enum Difficulty: String, CaseIterable {
        case easy
        case medium
        case hard
        
        var numberOfBombs: Int {
            switch self {
            case .easy:
                return 14 //20% of the board
            case .medium:
                return 22 //21% of the board
            case .hard:
                return 33 //22% of the board
            }
        }
        
        var boardSize: Board.Size {
            switch self {
            case .easy:
                return Board.Size(rows: 9, columns: 8)
            case .medium:
                return Board.Size(rows: 12, columns: 9)
            case .hard:
                return Board.Size(rows: 15, columns: 10)
            }
        }
        
        var totalCleanSquares: Int {
            return (boardSize.rows * boardSize.columns) - numberOfBombs
        }
        
        var title: String {
            rawValue.capitalizeFirstChar()
        }
    }
    
    var board: Board?
    var currentDifficulty: Difficulty
    
    init(difficulty: Difficulty = .medium) {
        board = nil
        currentDifficulty = difficulty
    }
}
