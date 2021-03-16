//
//  Record.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import Foundation

struct Record: Codable, Comparable {
    let date: Date
    let ownerName: String
    let timeInSeconds: Int
    
    static func < (lhs: Record, rhs: Record) -> Bool {
        return lhs.timeInSeconds < rhs.timeInSeconds
    }
}
