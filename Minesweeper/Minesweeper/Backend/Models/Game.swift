//
//  Game.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

struct Game {    
    var board: Board?
    var currentDifficulty: Difficulty
    
    init(difficulty: Difficulty = .medium) {
        board = nil
        currentDifficulty = difficulty
    }
}
