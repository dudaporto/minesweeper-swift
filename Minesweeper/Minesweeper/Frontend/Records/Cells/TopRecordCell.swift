//
//  TopRecordCell.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 16/09/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class TopRecordCell: UICollectionViewCell {
    
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var recordDateLabel: UILabel!
    @IBOutlet private weak var timeInSecondsLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    func setupCell(record: Record, podiumPosition: Int) {
        imageView.image = UIImage(systemName: "\(podiumPosition).circle")
        recordDateLabel.text = record.date.description
        timeInSecondsLabel.text = "\(record.timeInSeconds) s"
        userNameLabel.text = record.ownerName
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        timeInSecondsLabel.text = ""
        recordDateLabel.text = ""
        userNameLabel.text = ""
    }
}
