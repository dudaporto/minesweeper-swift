//
//  RecordCell.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 05/02/21.
//  Copyright © 2021 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class RecordCell: UICollectionViewCell {
    
    @IBOutlet private var ownerNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with record: Record) {
        ownerNameLabel.text = record.ownerName
    }
}
