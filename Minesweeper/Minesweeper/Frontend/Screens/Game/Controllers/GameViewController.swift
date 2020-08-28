//
//  GameViewController.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var boardContainer: UIView!
    @IBOutlet weak var boardHeightConstraint: NSLayoutConstraint!
    
    var game = Game(difficulty: .easy)
    private let squaresSpacing: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardContainer.backgroundColor = .clear
        game.delegate = self
        initBoardView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        calculateBoardPrefferedHeight()
    }
    
    @IBAction func restartButtonAction(_ sender: Any) {
        restart()
    }
    
    private func calculateBoardPrefferedHeight() {
        //calculates the height for subviews to be perfect squares
        let numberOfLines = game.currentDifficulty.boardSize.lines
        let numberOfColumns = game.currentDifficulty.boardSize.columns
        
        let lines = CGFloat(numberOfLines)
        let columns = CGFloat(numberOfColumns)
        let squaresWidth = (boardContainer.frame.width - squaresSpacing * (columns - 2)) / columns
        let height: CGFloat = squaresWidth * lines + squaresSpacing * (lines - 2)
        
        boardHeightConstraint.constant = height
    }
    
    private func restart() {
        game = Game()
        game.delegate = self
        
        boardContainer.subviews.forEach({ view in
            view.removeFromSuperview()
        })
        
        initBoardView()
        calculateBoardPrefferedHeight()
        boardContainer.isUserInteractionEnabled = true
    }
    
    private func initBoardView() {
        let boardView = BoardView(frame: boardContainer.frame)
        boardView.spacing = squaresSpacing
        boardView.setRows(boardSize: game.currentDifficulty.boardSize)
        boardView.delegate = game
        boardContainer.addSubview(boardView)
        
        NSLayoutConstraint.activate([
            boardView.heightAnchor.constraint(equalTo: boardContainer.heightAnchor),
            boardView.widthAnchor.constraint(equalTo: boardContainer.widthAnchor),
            boardView.centerXAnchor.constraint(equalTo: boardContainer.centerXAnchor)
        ])
    }
}

extension GameViewController: GameDelegate {
    func didWinGame() {
        let alert = UIAlertController(title: "VOCÊ GANHOU!", message: "Deseja jogar novamente?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Não", style: .destructive, handler: { _ in
            self.boardContainer.isUserInteractionEnabled = false
        }))
        
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { _ in
            self.restart()
        }))
        
        present(alert, animated: true)
    }
    
    func didLoseGame() {
        let alert = UIAlertController(title: "VOCÊ PERDEU!", message: "Deseja jogar novamente?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Não", style: .destructive, handler: { _ in
            self.boardContainer.isUserInteractionEnabled = false
        }))
        
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { _ in
            self.restart()
        }))
        
        present(alert, animated: true)
    }
}
