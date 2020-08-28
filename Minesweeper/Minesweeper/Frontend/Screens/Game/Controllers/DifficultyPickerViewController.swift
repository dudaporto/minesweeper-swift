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
    
    @IBAction private func easyButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: {
            self.delegate?.difficultyPickerDidSelectDifficulty(.easy)
        })
    }
    
    @IBAction private func mediumButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: {
            self.delegate?.difficultyPickerDidSelectDifficulty(.medium)
        })
    }
    
    @IBAction private func hardButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: {
            self.delegate?.difficultyPickerDidSelectDifficulty(.hard)
        })
    }
}
