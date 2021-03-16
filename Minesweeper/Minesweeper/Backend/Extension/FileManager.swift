//
//  FileManager.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 14/03/21.
//  Copyright © 2021 Maria Eduarda Porto. All rights reserved.
//

import Foundation

extension FileManager {
    static var documentDirectoryURL: URL {
        `default`.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
