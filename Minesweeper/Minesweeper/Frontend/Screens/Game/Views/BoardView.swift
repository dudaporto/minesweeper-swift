//
//  BoardView.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class BoardView: UIStackView {
    private let squaresSpacing: CGFloat = 3
    
    private func commonInit() {
        axis = .vertical
        spacing = squaresSpacing
        distribution = .fillEqually
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    func setRows(dimention: Int) {
        //let rowHeight = frame.height - (CGFloat(dimention - 2) * spacing)
        
        for _ in 0..<dimention {
            let row = UIStackView(arrangedSubviews: [])
            row.axis = .horizontal
            row.spacing = squaresSpacing
            row.distribution = .fillEqually
            
            for _ in 0..<dimention {
                let view = BoardSquareView(frame: .zero)
                row.addArrangedSubview(view)
            }
            
           addArrangedSubview(row)
        }
    }
}
