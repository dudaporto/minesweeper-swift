//
//  DifficultyRecords.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 14/03/21.
//  Copyright © 2021 Maria Eduarda Porto. All rights reserved.
//

import Foundation

struct DifficultyRecords: Codable, Identifiable {
    var id: Game.Difficulty {
        difficulty
    }
    
    let difficulty: Game.Difficulty
    var records: [Record]
}
