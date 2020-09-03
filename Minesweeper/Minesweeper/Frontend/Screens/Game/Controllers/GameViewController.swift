//
//  GameViewController.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    private let squaresSpacing: CGFloat = 2

    @IBOutlet private weak var restartButton: UIButton!
    @IBOutlet private weak var boardContainer: UIView!
    @IBOutlet private weak var boardBackground: UIView!
    @IBOutlet private weak var boardHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var flagsLabel: UILabel!
    @IBOutlet private weak var timerLabel: UILabel!
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardContainer.backgroundColor = .clear
        startNewGame(difficulty: DifficultyManager.getSelectedDifficulty())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calculateBoardPrefferedHeight()
    }
    
    @IBAction func restartButtonAction(_ sender: Any) {
        startNewGame()
    }

    @IBSegueAction func showDifficultyPicker(_ coder: NSCoder) -> UIViewController? {
        let viewController = DifficultyPickerViewController(coder: coder)
        viewController?.delegate = self
        viewController?.selectedDifficulty = game.currentDifficulty
        return viewController
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
        
        flagsLabel.text = "\(difficulty.numberOfBombs)".addLeadingZeros(stringLength: 3)
        
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
        boardView.delegate = self
        boardContainer.addSubview(boardView)
        
        NSLayoutConstraint.activate([
            boardView.heightAnchor.constraint(equalTo: boardContainer.heightAnchor),
            boardView.widthAnchor.constraint(equalTo: boardContainer.widthAnchor),
            boardView.centerXAnchor.constraint(equalTo: boardContainer.centerXAnchor)
        ])
    }
    
    private func setupRestartButton(isEnabled: Bool) {
        restartButton.isEnabled = isEnabled
        restartButton.alpha = isEnabled ? 1 : 0.7
    }

//MARK: -  Timer
    private var timerCounter = 0
    private var timer: Timer?
    
    @objc private func runTimer() {
        timerCounter += 1
        let secondsText = "\(timerCounter)".addLeadingZeros(stringLength: 3)
        timerLabel.text  = secondsText
    }
    
    private func invalidateTimer() {
        timer?.invalidate()
        timerLabel.text = "000"
        timerCounter = 0
    }

//MARK: - Game Essentials
    private func didStartBoard() {
        setupRestartButton(isEnabled: true)
        timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(runTimer),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    private func didWinGame() {
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
    
    private func didLoseGame() {
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

//MARK: - Board View Delegate
extension GameViewController: BoardViewDelegate {
    func boardViewDelegate(_ boardView: BoardView, didClickAtSquare square: BoardSquareButton) {
        // initializes the values ​​only after the first click
        if game.board == nil {
            game.board = Board(difficulty: game.currentDifficulty, initialSquarePosition: square.positionInBoard!)
            boardView.setValues(values: game.board!.values)
            didStartBoard()
        }
        
        guard !square.isBomb else {
            boardView.performLoseAnimation()
            didLoseGame()
            return
        }
        
        boardView.reveal(from: square, in: game.currentDifficulty.boardSize)
        
        if boardView.squaresRevealed == game.currentDifficulty.totalCleanSquares {
            boardView.performWinAnimation()
            didWinGame()
        }
    }
    
    func boardViewDelegate(_ boardView: BoardView, didFlagSquare square: BoardSquareButton) {
        // initializes board if the first action was to flag a square
        if game.board == nil {
            game.board = Board(difficulty: game.currentDifficulty, initialSquarePosition: square.positionInBoard!)
            boardView.setValues(values: game.board!.values)
            didStartBoard()
        }
        
        var bombsLeft = game.currentDifficulty.numberOfBombs - boardView.squaresFlagged
        if bombsLeft < 0 {
            bombsLeft = 0
        }
        
        flagsLabel.text = "\(bombsLeft)".addLeadingZeros(stringLength: 3)
    }
}

//MARK: - Difficulty Picker View Controller Delegate
extension GameViewController: DifficultyPickerViewControllerDelegate {
    func difficultyPickerDidSelectDifficulty(_ difficulty: Game.Difficulty) {
        if difficulty != game.currentDifficulty {
            startNewGame(difficulty: difficulty)
        }
    }
}
