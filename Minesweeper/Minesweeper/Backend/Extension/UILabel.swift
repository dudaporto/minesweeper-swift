//
//  UILabel.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 08/02/21.
//  Copyright © 2021 Maria Eduarda Porto. All rights reserved.
//

import UIKit

extension UILabel {
    @IBInspectable var localizedKey: String? {
        get {
            nil
        }
        set {
            guard let localizedKey = newValue else {
                return
            }
            
            text = NSLocalizedString(localizedKey, comment: "")
        }
    }
}
