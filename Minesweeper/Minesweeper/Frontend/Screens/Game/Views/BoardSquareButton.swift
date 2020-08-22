//
//  BoardSquareButton.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import UIKit

protocol BoardSquareDelegate: NSObjectProtocol {
    func boardSquareClicked(_ square: BoardSquareButton)
}

class BoardSquareButton: UIButton {
    weak var delegate: BoardSquareDelegate?
    
    var positionInBoard: Position?
    var boardSquare: BoardSquare? {
        didSet {
            setupStyle()
        }
    }
    
    private func commonInit() {
        self.backgroundColor = .lightGray
        
        addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    private func setupStyle() {
        self.setTitle("\(boardSquare!.value)", for: [])
        self.titleLabel!.font = UIFont.boldSystemFont(ofSize: 14)
        
        switch boardSquare?.value {
        case 1:
            self.setTitleColor(.red, for: [])
        case 2:
            self.setTitleColor(.green, for: [])
        case 3:
            self.setTitleColor(.blue, for: [])
        case 4:
            self.setTitleColor(.purple, for: [])
        case 5:
            self.setTitleColor(.orange, for: [])
        case 6:
            self.setTitleColor(.systemPink, for: [])
        case 7:
            self.setTitleColor(.magenta, for: [])
        case 8:
            self.setTitleColor(.brown, for: [])
        case -1:
            self.setTitle("*", for: [])
            self.setTitleColor(.black, for: [])
        case .none:
            break
        default:
            self.setTitleColor(.white, for: [])
            
        }
    }
    
    @objc func click() {
        delegate?.boardSquareClicked(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
}

