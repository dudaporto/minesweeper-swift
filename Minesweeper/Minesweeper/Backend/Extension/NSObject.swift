//
//  NSObject.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 25/01/21.
//  Copyright © 2021 Maria Eduarda Porto. All rights reserved.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
