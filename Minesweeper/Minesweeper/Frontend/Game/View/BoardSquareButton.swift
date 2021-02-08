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
    var isFlagged: Bool {
        squareState == .flagged
    }
    
    var isShowingPlaceholer = false
    
    weak var delegate: BoardSquareDelegate?

    private func commonInit() {
        self.backgroundColor = UIColor.systemGray.withAlphaComponent(0.5)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(flagAction(lgr:)))
        longGesture.minimumPressDuration = 0.15
        addGestureRecognizer(longGesture)
        addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    private func setupStyle() {
        titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        switch value {
        case 1:
            self.setTitleColor(.systemRed, for: [])
        case 2:
            self.setTitleColor(.systemGreen, for: [])
        case 3:
            self.setTitleColor(.systemBlue, for: [])
        case 4:
            self.setTitleColor(.systemPurple, for: [])
        case 5:
            self.setTitleColor(.systemOrange, for: [])
        case 6:
            self.setTitleColor(.systemPink, for: [])
        case 7:
            self.setTitleColor(.systemYellow, for: [])
        case 8:
            self.setTitleColor(.systemTeal, for: [])
        default:
            self.setTitleColor(.clear, for: [])
        }
    }
    
    private func setBombsImage() {
        self.tintColor = .black
        let bombImage = UIImage(named: "ic_bomb")
        self.setImage(bombImage, for: [])
    }
    
    func reveal() {
        self.squareState = .revealed
        self.backgroundColor = UIColor.systemGray.withAlphaComponent(0.3)
        
        if isBomb {
            setBombsImage()
        } else {
            self.setTitle("\(value)", for: [])
        }
    }
    
    func toggleFlagPlaceholder() {
        guard !isFlagged else {
            return
        }
        
        let flagImage = UIImage(systemName: "flag.fill")
        tintColor = UIColor.black.withAlphaComponent(0.2)
        
        self.setImage(isShowingPlaceholer ? nil : flagImage, for: [])
        
        isShowingPlaceholer = !isShowingPlaceholer
    }
    
    func toggleFlag() {
        guard squareState != .revealed else {
            return
        }
        
        let flagImage = UIImage(systemName: "flag.fill")
        self.tintColor = .systemOrange
        
        //toggle the flag state
        squareState = isFlagged ? .unrevealed : .flagged
        self.setImage(isFlagged ? flagImage : nil, for: [])
        delegate?.boardSquareDidToggleFlag(self)
    }
    
    @objc func click() {
        guard squareState != .revealed else {
            return
        }
        
        delegate?.boardSquareClicked(self)
    }
    
    @objc func flagAction(lgr: UILongPressGestureRecognizer) {
        guard lgr.state == .began, squareState != .revealed else {
            return
        }
        
        toggleFlag()
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

