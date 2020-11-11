//
//  BoardView.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import UIKit

protocol BoardViewDelegate: NSObjectProtocol {
    func boardViewDelegate(_ boardView: BoardView, didClickAtSquare square: BoardSquareButton)
    func boardViewDelegate(_ boardView: BoardView, didFlagSquare square: BoardSquareButton)
}

class BoardView: UIStackView {
    weak var delegate: BoardViewDelegate?
    
    private func commonInit() {
        axis = .vertical
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
    
    var numberOfRows = 0
    var numberOfColumns = 0
    var isFlagModeActive = false
    
    var boardSize: Board.Size {
        return Board.Size(rows: numberOfRows, columns: numberOfColumns)
    }
    
    private(set) var squaresRevealed = 0
    private(set) var squaresFlagged = 0
    
    func setRows(boardSize: Board.Size) {
        numberOfRows = boardSize.rows
        numberOfColumns = boardSize.columns
        
        for i in 0..<numberOfRows {
            let row = UIStackView(arrangedSubviews: [])
            row.axis = .horizontal
            row.spacing = spacing
            row.distribution = .fillEqually
            
            for j in 0..<numberOfColumns {
                let square = BoardSquareButton(type: .system)
                square.positionInBoard = Position(row: i, col: j)
                square.delegate = self
                row.addArrangedSubview(square)
            }
            
           addArrangedSubview(row)
        }
    }
    
    func setValues(values: [[Int]]) {
        for i in 0..<numberOfRows {
            for j in 0..<numberOfColumns {
                getSquare(at: Position(row: i, col: j))?.value = values[i][j]
            }
        }
    }
    
    func getSquare(at position: Position) -> BoardSquareButton? {
        guard let row = arrangedSubviews[position.row] as? UIStackView,
            let square = row.arrangedSubviews[position.col] as? BoardSquareButton else {
                return nil
        }
        
        return square
    }
    
    func reveal(from square: BoardSquareButton) {
        guard square.squareState == .unrevealed else {
            return
        }
        
        square.reveal()
        squaresRevealed += 1
        
        if square.value == 0 {
            //check the neighbors
            for i in -1...1 {
                for j in -1...1 {
                    let row = square.positionInBoard!.row + i
                    let col = square.positionInBoard!.col + j
                    let position = Position(row: row, col: col)
                    
                    if position.isValid(in: boardSize),
                        let square = getSquare(at: position) {
                        reveal(from: square)
                    }
                }
            }
        }
    }
    
    func revealAll(isAWin: Bool = false) {
        for i in 0..<boardSize.rows {
            for j in 0..<boardSize.columns {
                let position = Position(row: i, col: j)
                
                if let square = getSquare(at: position), square.squareState == .unrevealed  {
                    square.reveal()
                    if square.isBomb, isAWin {
                        square.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.4)
                    }
                }
            }
        }
    }
    
    func toogleFlagPlaceholderInAll() {
        for i in 0..<boardSize.rows {
            for j in 0..<boardSize.columns {
                let position = Position(row: i, col: j)
                
                if let square = getSquare(at: position), square.squareState != .revealed  {
                    square.toggleFlagPlaceholder()
                }
            }
        }
    }
    
    func performWinAnimation() {
        revealAll(isAWin: true)
    }
    
    func performLoseAnimation() {
        revealAll()
    }
}

extension BoardView: BoardSquareDelegate {
    func boardSquareDidToggleFlag(_ square: BoardSquareButton) {
        squaresFlagged += square.isFlagged ? 1 : -1
        delegate?.boardViewDelegate(self, didFlagSquare: square)
    }
    
    func boardSquareClicked(_ square: BoardSquareButton) {
        if isFlagModeActive {
            square.toggleFlag()
            squaresFlagged += square.isFlagged ? 1 : -1
            delegate?.boardViewDelegate(self, didFlagSquare: square)
            return
        }
        
        guard !square.isFlagged else {
            return
        }
        
        delegate?.boardViewDelegate(self, didClickAtSquare: square)
    }
}
