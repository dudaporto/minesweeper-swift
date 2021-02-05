//
//  String.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 02/09/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import Foundation

extension String {
    func addLeadingZeros(stringLength: Int) -> String {
        var string = self
        for _ in string.count..<stringLength {
            string = "0\(string)"
        }
        return string
    }
    
    func capitalizeFirstChar() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
