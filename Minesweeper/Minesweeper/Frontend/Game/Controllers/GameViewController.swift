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
    private let animationDuration: TimeInterval = 0.20

    @IBOutlet private weak var boardBackground: UIView!
    @IBOutlet private weak var boardContainer: UIView!
    @IBOutlet private weak var boardHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var flagModeButton: UIButton!
    @IBOutlet private weak var flagsLabel: UILabel!
    @IBOutlet private weak var headerBottomLine: UIView!
    @IBOutlet private weak var headerBottomLineWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var optionsButton: UIButton!
    @IBOutlet private weak var restartButton: UIButton!
    @IBOutlet private weak var timerLabel: UILabel!
    
    var game: Game!
    
    private var isFlagModeActive: Bool = false {
        didSet {
            updateFlagMode()
        }
    }
    
    private var boardView: BoardView? {
        (boardContainer.subviews.first as? BoardView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        let initialDifficulty = DifficultyManager.getSelectedDifficulty()
        setupDifficultyColor(initialDifficulty)
        startNewGame(difficulty: initialDifficulty)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calculateBoardPrefferedHeight()
    }
    
    private func setupNavigationBar() {
        title = NSLocalizedString("game_title", comment: "")
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    @IBAction private func flagModeAction(_ sender: Any) {
        isFlagModeActive = !isFlagModeActive
        boardView?.isFlagModeActive = isFlagModeActive
    }
    
    @IBAction private func restartButtonAction(_ sender: Any) {
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
        let numberOfRows = game.currentDifficulty.boardSize.rows
        let numberOfColumns = game.currentDifficulty.boardSize.columns
        
        let rows = CGFloat(numberOfRows)
        let columns = CGFloat(numberOfColumns)
        let squaresWidth = (boardContainer.frame.width - squaresSpacing * (columns - 2)) / columns
        let height: CGFloat = squaresWidth * rows + squaresSpacing * (rows - 2)
        
        boardHeightConstraint.constant = height
    }
    
    private func setBoardView() {
        let boardView = BoardView(frame: boardContainer.frame)
        boardView.spacing = squaresSpacing
        boardView.setRows(boardSize: game.currentDifficulty.boardSize)
        boardView.delegate = self
        
        UIView.transition(
            with: boardContainer,
            duration: animationDuration,
            options: .transitionCrossDissolve, animations: {
                self.boardContainer.subviews.forEach({ view in
                    view.removeFromSuperview()
                })
                self.boardContainer.addSubview(boardView)
            }, completion: { _ in
                self.animateHeaderBottomLine()
            })
        
        NSLayoutConstraint.activate([
            boardView.heightAnchor.constraint(equalTo: boardContainer.heightAnchor),
            boardView.widthAnchor.constraint(equalTo: boardContainer.widthAnchor),
            boardView.centerXAnchor.constraint(equalTo: boardContainer.centerXAnchor)
        ])
        
        calculateBoardPrefferedHeight()
        boardContainer.isUserInteractionEnabled = true
    }
    
    private func startNewGame(difficulty: Game.Difficulty? = nil) {
        invalidateTimer()
        flagModeButton.isEnabled = true
        isFlagModeActive = false
        
        let difficulty = difficulty ?? game.currentDifficulty
        game = Game(difficulty: difficulty)
        
        flagsLabel.text = "\(difficulty.numberOfBombs)".addLeadingZeros(stringLength: 3)
        
        setBoardView()
        setupRestartButton(isEnabled: false)
    }
    
    private func animateHeaderBottomLine() {
        self.headerBottomLineWidthConstraint.constant = self.view.frame.width
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.view.layoutIfNeeded()
        }, completion:  { _ in
            UIView.animate(withDuration: self.animationDuration, animations: {
                self.headerBottomLine.alpha = 0
            }, completion: { _ in
                self.headerBottomLineWidthConstraint.constant = 0
                self.headerBottomLine.alpha = 1
            })
        })
    }
    
    private func setupRestartButton(isEnabled: Bool) {
        restartButton.isEnabled = isEnabled
        restartButton.alpha = isEnabled ? 1 : 0.7
    }
    
    private func setupDifficultyColor(_ difficulty: Game.Difficulty) {
        navigationController?.navigationBar.tintColor = difficulty.color
        optionsButton.tintColor = difficulty.color
        flagModeButton.tintColor = difficulty.color
        headerBottomLine.backgroundColor = difficulty.color
        restartButton.tintColor = difficulty.color
    }
    
    private func updateFlagMode() {
        boardView?.toogleFlagPlaceholderInAll()
        if isFlagModeActive {
            flagModeButton.borderColor = .systemGreen
            flagsLabel.textColor = .systemGreen
            timerLabel.textColor = .systemGreen
        } else {
            flagModeButton.borderColor = .clear
            flagsLabel.textColor = .white
            timerLabel.textColor = .white
        }
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
        flagModeButton.isEnabled = false
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
        flagModeButton.isEnabled = false
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
            square.backgroundColor = UIColor.systemRed.withAlphaComponent(0.6)
            didLoseGame()
            
            return
        }
        
        boardView.reveal(from: square)
        
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
            setupDifficultyColor(difficulty)
            startNewGame(difficulty: difficulty)
        }
    }
    
    func difficultyPickerDidClickAtBackToMenuButton() {
        let _ = self.navigationController?.popToRootViewController(animated: true)
    }
}
