//
//  DifficultyPickerViewController.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 27/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import UIKit

protocol DifficultyPickerViewControllerDelegate: NSObjectProtocol {
    func difficultyPickerDidSelectDifficulty(_ difficulty: Game.Difficulty)
    func difficultyPickerDidClickAtBackToMenuButton()
}

class DifficultyPickerViewController: UIViewController {
    weak var delegate: DifficultyPickerViewControllerDelegate?
    
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!

    var selectedDifficulty: Game.Difficulty = .easy
    
    private func updateSelectedButton() {
        easyButton.borderColor = .clear
        mediumButton.borderColor = .clear
        hardButton.borderColor = .clear
        
        switch selectedDifficulty {
        case .easy:
            easyButton.borderColor = .link
        case .medium:
            mediumButton.borderColor = .link
        case .hard:
            hardButton.borderColor = .link
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSelectedButton()
    }
    
    @IBAction private func checkButtonClicked(_ sender: Any) {
        dismiss(animated: true) {
            self.delegate?.difficultyPickerDidSelectDifficulty(self.selectedDifficulty)
            DifficultyManager.saveSeletedDifficulty(self.selectedDifficulty)
        }
    }
    
    @IBAction private func leaveToMenuButtonClicked(_ sender: Any) {
        dismiss(animated: true) {
            self.delegate?.difficultyPickerDidClickAtBackToMenuButton()
        }
    }
    
    @IBAction private func backgroundViewClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction private func easyButtonClicked(_ sender: Any) {
        selectedDifficulty = .easy
        updateSelectedButton()
    }
    
    @IBAction private func mediumButtonClicked(_ sender: Any) {
        selectedDifficulty = .medium
        updateSelectedButton()
    }
    
    @IBAction private func hardButtonClicked(_ sender: Any) {
        selectedDifficulty = .hard
        updateSelectedButton()
    }
}
