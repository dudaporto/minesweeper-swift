//
//  GameViewController.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var boardHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let game = Game(difficulty: .hard)
        
        boardView.setRows(boardSize: game.currentDifficulty.boardSize, values: game.board.board)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        boardHeightConstraint.constant = boardView.prefferedHeight
    }
}

