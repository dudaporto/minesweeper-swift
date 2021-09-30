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
}

class DifficultyPickerViewController: UIViewController {
    weak var delegate: DifficultyPickerViewControllerDelegate?
    
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!

    var selectedDifficulty: Game.Difficulty = .easy
    
    private func updateSelectedButton() {
        clearButton(easyButton)
        clearButton(mediumButton)
        clearButton(hardButton)
        
        // minha alteração
        
        switch selectedDifficulty {
        case .easy:
            selectButton(easyButton)
        case .medium:
            selectButton(mediumButton)
        case .hard:
            selectButton(hardButton)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSelectedButton()
    }
    
    private func clearButton(_ button: UIButton) {
        button.borderColor = .clear
        button.setTitleColor(.link, for: .normal)
    }
    
    private func selectButton(_ button: UIButton) {
        button.borderColor = selectedDifficulty.color
        button.setTitleColor(selectedDifficulty.color, for: .normal)
    }
    
    @IBAction private func checkButtonClicked(_ sender: Any) {
        dismiss(animated: true) {
            self.delegate?.difficultyPickerDidSelectDifficulty(self.selectedDifficulty)
            DifficultyManager.saveSeletedDifficulty(self.selectedDifficulty)
        }
    }
    
    @IBAction private func leaveToMenuButtonClicked(_ sender: Any) {
        dismiss(animated: true)
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

class CheckButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                borderColor = .systemGreen
                tintColor = .systemGreen
            } else {
                borderColor = .clear
                tintColor = .systemBlue
            }
        }
    }
}

class CloseButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                borderColor = .systemRed
                tintColor = .systemRed
            } else {
                borderColor = .clear
                tintColor = .systemBlue
            }
        }
    }
}

