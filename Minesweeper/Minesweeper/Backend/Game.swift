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
        case easy = 8
        case medium = 12
        case hard = 16
        
        var numberOfBombs: Int {
            rawValue * 2
        }
        
        var dimention: Int {
            rawValue
        }
    }
    
    let currentDifficulty: Difficulty
    let board: Board
    
    init(difficulty: Difficulty) {
        currentDifficulty = difficulty
        board = Board(difficulty: difficulty)
    }
}
