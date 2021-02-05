//
//  UICollectionViewCell.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 05/02/21.
//  Copyright © 2021 Maria Eduarda Porto. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    static func nib() -> UINib {
        return UINib(nibName: self.className, bundle: nil)
    }
}
