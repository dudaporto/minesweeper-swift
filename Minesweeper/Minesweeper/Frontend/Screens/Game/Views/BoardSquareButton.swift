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
    func boardSquareDidToggleFlag(_ square: BoardSquareButton)
}

class BoardSquareButton: UIButton {
    enum State {
        case revealed
        case unrevealed
        case flagged
    }
    
    var value: Int = 0 {
        didSet {
            setupStyle()
        }
    }
    
    var squareState: State = .unrevealed
    var positionInBoard: Position?
    var isBomb: Bool {
        value == -1
    }
    
    weak var delegate: BoardSquareDelegate?

    private func commonInit() {
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(flag(lgr:)))
        longGesture.minimumPressDuration = 0.3
        addGestureRecognizer(longGesture)
        addTarget(self, action: #selector(click), for: .touchUpInside)
        
        titleLabel!.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
    }
    
    private func setupStyle() {
        switch value {
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
        default:
            self.setTitleColor(.white, for: [])
        }
    }
    
    func reveal() {
        self.squareState = .revealed
        self.setTitle("\(value)", for: [])
    }
    
    @objc func click() {
        guard squareState == .unrevealed else {
            return
        }
        
        delegate?.boardSquareClicked(self)
    }
    
    @objc func flag(lgr: UILongPressGestureRecognizer) {
        guard lgr.state == .began, squareState != .revealed else {
            return
        }
        
        //toggle the flag state
        squareState = squareState == .flagged ? .unrevealed : .flagged
        let title = squareState == .flagged ? "F" : ""
        setTitle(title, for: [])
        delegate?.boardSquareDidToggleFlag(self)
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

