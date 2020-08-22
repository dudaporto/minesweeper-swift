//
//  UIView.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import UIKit

extension UIView {
    func loadNib() -> UIView {
        let bundle = Bundle(for: Self.self)
        let nibName = String(describing: Self.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        return (nib.instantiate(withOwner: self, options: nil).filter { $0 is UIView }).first as! UIView
    }
}
