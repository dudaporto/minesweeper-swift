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
    
    let game = Game(difficulty: .easy)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardView.setRows(boardSize: game.currentDifficulty.boardSize)
        boardView.delegate = game
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        boardHeightConstraint.constant = boardView.prefferedHeight
        
    }
}
