//
//  Game.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import Foundation

class Game {
    enum Difficulty: Int {
        case easy = 15
        case medium = 20
        case hard = 30
        
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
    }
    
    let currentDifficulty: Difficulty
    let board: Board
    
    init(difficulty: Difficulty) {
        currentDifficulty = difficulty
        board = Board(difficulty: difficulty)
    }
}
