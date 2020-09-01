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
                return 12
            case .medium:
                return 25
            case .hard:
                return 35
            }
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
    
    var board: Board?
    var currentDifficulty: Difficulty
    
    init(difficulty: Difficulty = .medium) {
        board = nil
        currentDifficulty = difficulty
    }
}
