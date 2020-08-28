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
    
    var numberOfLines = 0
    var numberOfColumns = 0
    
    func setRows(boardSize: Board.Size) {
        numberOfLines = boardSize.lines
        numberOfColumns = boardSize.columns
        
        for i in 0..<numberOfLines {
            let row = UIStackView(arrangedSubviews: [])
            row.axis = .horizontal
            row.spacing = spacing
            row.distribution = .fillEqually
            
            for j in 0..<numberOfColumns {
                let square = BoardSquareButton(type: .system)
                square.positionInBoard = Position(lin: i, col: j)
                square.delegate = self
                row.addArrangedSubview(square)
            }
            
           addArrangedSubview(row)
        }
    }
    
    func setValues(values: [[Int]]) {
        for i in 0..<numberOfLines {
            for j in 0..<numberOfColumns {
                getSquare(at: Position(lin: i, col: j))?.value = values[i][j]
            }
        }
    }
    
    func getSquare(at position: Position) -> BoardSquareButton? {
        guard let row = arrangedSubviews[position.lin] as? UIStackView,
            let square = row.arrangedSubviews[position.col] as? BoardSquareButton else {
                return nil
        }
        
        return square
    }
    
    func performWinAnimation() {
    }
    
    func performLoseAnimation() {
    }
}

extension BoardView: BoardSquareDelegate {
    func boardSquareDidToggleFlag(_ square: BoardSquareButton) {
        // do nothing by now
    }
    
    func boardSquareClicked(_ square: BoardSquareButton) {
        delegate?.boardViewDelegate(self, didClickAtSquare: square)
    }
}
