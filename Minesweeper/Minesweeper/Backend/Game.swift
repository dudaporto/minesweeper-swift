//
//  Game.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import Foundation

final class Game: NSObject {
    enum Difficulty: String {
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
                return Board.Size(lines: 9, columns: 8)
            case .medium:
                return Board.Size(lines: 12, columns: 9)
            case .hard:
                return Board.Size(lines: 15, columns: 10)
            }
        }
        
        var totalCleanSquares: Int {
            return (boardSize.lines * boardSize.columns) - numberOfBombs
        }
    }
    
    var board: Board?
    var currentDifficulty: Difficulty
    
    init(difficulty: Difficulty = .medium) {
        board = nil
        currentDifficulty = difficulty
    }
}
