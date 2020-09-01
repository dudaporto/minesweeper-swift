//
//  GameViewController.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet private weak var difficultyLabel: UILabel!
    @IBOutlet private weak var restartButton: UIButton!
    @IBOutlet private weak var boardContainer: UIView!
    @IBOutlet private weak var boardHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var flagsLabel: UILabel!
    @IBOutlet private weak var timerLabel: UILabel!
    
    private var timerCounter = 0
    private var timer: Timer?
    
    var game = Game(difficulty: .easy)
    private let squaresSpacing: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardContainer.backgroundColor = .clear
        startNewGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        calculateBoardPrefferedHeight()
    }

    @IBSegueAction func showDifficultyPicker(_ coder: NSCoder) -> UIViewController? {
        let viewController = DifficultyPickerViewController(coder: coder)
        viewController?.delegate = self
        return viewController
    }
    
    @IBAction func restartButtonAction(_ sender: Any) {
        startNewGame()
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
    
    private func startNewGame(difficulty: Game.Difficulty? = nil) {
        invalidateTimer()
        
        let difficulty = difficulty ?? game.currentDifficulty
        game = Game(difficulty: difficulty)
        game.delegate = self
        
        flagsLabel.text = "\(difficulty.numberOfBombs)"
        
        boardContainer.subviews.forEach({ view in
            view.removeFromSuperview()
        })
        
        initBoardView()
        calculateBoardPrefferedHeight()
        boardContainer.isUserInteractionEnabled = true
        setupRestartButton(isEnabled: false)
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
    
    func setupRestartButton(isEnabled: Bool) {
        restartButton.isEnabled = isEnabled
        restartButton.alpha = isEnabled ? 1 : 0.7
    }
    
    @objc private func runTimer() {
        timerCounter += 1
        let minutes = timerCounter / 60
        let seconds = timerCounter % 60
        let minutesText = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let secondsText = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        timerLabel.text = "\(minutesText):\(secondsText)"
    }
    
    private func invalidateTimer() {
        timer?.invalidate()
        timerLabel.text = "00:00"
        timerCounter = 0
    }
}

extension GameViewController: GameDelegate {
    func didStartBoard() {
        setupRestartButton(isEnabled: true)
        timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(runTimer),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    func didWinGame() {
        timer?.invalidate()
        
        let alert = UIAlertController(title: "VOCÊ GANHOU!", message: "Deseja jogar novamente?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Não", style: .destructive, handler: { _ in
            self.boardContainer.isUserInteractionEnabled = false
        }))
        
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { _ in
            self.startNewGame()
        }))
        
        present(alert, animated: true)
    }
    
    func didLoseGame() {
        timer?.invalidate()
        
        let alert = UIAlertController(title: "VOCÊ PERDEU!", message: "Deseja jogar novamente?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Não", style: .destructive, handler: { _ in
            self.boardContainer.isUserInteractionEnabled = false
        }))
        
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { _ in
            self.startNewGame()
        }))
        
        present(alert, animated: true)
    }
}

extension GameViewController: DifficultyPickerViewControllerDelegate {
    func difficultyPickerDidSelectDifficulty(_ difficulty: Game.Difficulty) {
        switch difficulty {
        case .easy:
            difficultyLabel.text = "Easy"
        case .medium:
            difficultyLabel.text = "Medium"
        case .hard:
            difficultyLabel.text = "Hard"
        }
        
        startNewGame(difficulty: difficulty)
    }
}
