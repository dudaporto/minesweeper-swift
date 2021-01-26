//
//  RecordCell.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 16/09/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class RecordCell: UICollectionViewCell {
    
    @IBOutlet private weak var positionLabel: UILabel!
    @IBOutlet private weak var timeInSecondsLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    
    func setupCell(record: Record, podiumPosition: Int) {
        positionLabel.text = "\(podiumPosition)"
        timeInSecondsLabel.text = "\(record.timeInSeconds) s"
        userNameLabel.text = record.ownerName
    }
    
    override func prepareForReuse() {
        positionLabel.text = ""
        timeInSecondsLabel.text = ""
        userNameLabel.text = ""
    }
}
