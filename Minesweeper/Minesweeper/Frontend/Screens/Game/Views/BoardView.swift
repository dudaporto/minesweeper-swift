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
    
    var numberOfLines = 0
    var numberOfColumns = 0
    
    var prefferedHeight: CGFloat {
        //calculates the height for subviews to be perfect squares
        
        let lines = CGFloat(numberOfLines)
        let columns = CGFloat(numberOfColumns)
        let squaresWidth = (frame.width - squaresSpacing * (columns - 2)) / columns
        let height: CGFloat = squaresWidth * lines + squaresSpacing * (lines - 2)
        return height
    }
    
    func setRows(boardSize: Board.Size, values: [[BoardSquare]]) {
        numberOfLines = boardSize.lines
        numberOfColumns = boardSize.columns
        
        for i in 0..<numberOfLines {
            let row = UIStackView(arrangedSubviews: [])
            row.axis = .horizontal
            row.spacing = squaresSpacing
            row.distribution = .fillEqually
            
            for j in 0..<numberOfColumns {
                let square = BoardSquareButton(frame: .zero)
                square.positionInBoard = Position(lin: i, col: j)
                square.boardSquare = values[i][j]
                square.delegate = self
                row.addArrangedSubview(square)
            }
            
           addArrangedSubview(row)
        }
    }
}

extension BoardView: BoardSquareDelegate {
    func boardSquareClicked(_ square: BoardSquareButton) {
        print("Quadrado clicado em linha: \(square.positionInBoard?.lin) e coluna: \(square.positionInBoard?.col)")
    }
}
