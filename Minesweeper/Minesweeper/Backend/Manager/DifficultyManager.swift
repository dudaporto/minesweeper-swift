//
//  DifficultyManager.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 31/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import Foundation

final class DifficultyManager {
    //MARK: - USER DEFAULTS
    static private let selectedDifficultyUserDefaultsKey = "Minesweeper.selectedDifficulty"
    
    static func saveSeletedDifficulty(_ difficulty: Game.Difficulty) {
        UserDefaults.standard.set(difficulty.rawValue, forKey: DifficultyManager.selectedDifficultyUserDefaultsKey)
    }
    
    static func getSelectedDifficulty() -> Game.Difficulty {
        let rawValue = UserDefaults.standard.string(forKey: selectedDifficultyUserDefaultsKey) ?? Game.Difficulty.medium.rawValue
        return Game.Difficulty(rawValue: rawValue)!
    }
}
