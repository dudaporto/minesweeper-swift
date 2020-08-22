//
//  BoardSquare.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import Foundation

struct BoardSquare {
    enum State {
        case revealed
        case unrevealed
        case flagged
    }
    
    var value: Int = 0
    var state: State = .unrevealed
    
    var isBomb: Bool {
        value == -1
    }
}
