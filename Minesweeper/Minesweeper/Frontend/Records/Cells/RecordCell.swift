//
//  RecordCell.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 05/02/21.
//  Copyright © 2021 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class RecordCell: UICollectionViewCell {
    static let height: CGFloat = 70.0
    
    @IBOutlet private weak var ownerNameLabel: UILabel!
    @IBOutlet private weak var positionLabel: UILabel!
    @IBOutlet private weak var timeInSecondsLabel: UILabel!

    var color: UIColor? {
        didSet {
            guard let color = color else {
                return
            }
            
            positionLabel.textColor = color
            timeInSecondsLabel.textColor = color
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(with record: Record, and position: Int) {
        ownerNameLabel.text = record.ownerName
        positionLabel.text = "\(position)"
        timeInSecondsLabel.text = "\(record.timeInSeconds) s"
    }
    
    override func prepareForReuse() {
        ownerNameLabel.text = ""
        positionLabel.text = ""
        timeInSecondsLabel.text = ""
    }
}
