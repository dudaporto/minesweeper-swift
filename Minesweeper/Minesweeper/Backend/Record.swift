//
//  Record.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import Foundation

struct Record {
    let date: Date
    let difficulty: Game.Difficulty
    let ownerName: String
    let timeInSeconds: Int
    
    static var mock: [Record] = [
        Record(date: Date(), difficulty: .easy, ownerName: "Duda", timeInSeconds: 190),
        Record(date: Date(), difficulty: .medium, ownerName: "Gui", timeInSeconds: 198),
        Record(date: Date(), difficulty: .medium, ownerName: "Duda", timeInSeconds: 215),
        Record(date: Date(), difficulty: .medium, ownerName: "Roza", timeInSeconds: 221),
        Record(date: Date(), difficulty: .easy, ownerName: "User1", timeInSeconds: 236),
    ]
}
