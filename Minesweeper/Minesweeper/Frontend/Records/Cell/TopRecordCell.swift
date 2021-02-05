//
//  TopRecordCell.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 05/02/21.
//  Copyright © 2021 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class TopRecordCell: UICollectionViewCell {
    static let height: CGFloat = 80.0

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var ownerNameLabel: UILabel!
    @IBOutlet private weak var timeInSecondsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(with record: Record) {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        
        dateLabel.text = dateFormatter.string(from: record.date)
        ownerNameLabel.text = record.ownerName
        timeInSecondsLabel.text = "\(record.timeInSeconds) s"
    }
    
    override func prepareForReuse() {
        dateLabel.text = ""
        ownerNameLabel.text = ""
        timeInSecondsLabel.text = ""
    }
}
