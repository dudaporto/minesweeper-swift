//
//  RecordCell.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 16/09/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class RecordCell: UICollectionViewCell {
    
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var timeInSecondsLabel: UILabel!
    @IBOutlet private weak var positionLabel: UILabel!
    
    func setupCell(userName: String, timeInSeconds: Int, podiumPosition: Int) {
        userNameLabel.text = userName
        timeInSecondsLabel.text = "\(timeInSeconds) s"
        positionLabel.text = "\(podiumPosition)"
    }
    
    override func prepareForReuse() {
        userNameLabel.text = ""
        timeInSecondsLabel.text = ""
        positionLabel.text = ""
    }
}
