//
//  TopThreeRecordCell.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 16/09/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class TopThreeRecordCell: UICollectionViewCell {
    
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var recordDateLabel: UILabel!
    @IBOutlet private weak var timeInSecondsLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    func setupCell(userName: String, recordDate: Date, timeInSeconds: Int, podiumPosition: Int) {
        userNameLabel.text = userName
        recordDateLabel.text = recordDate.description
        timeInSecondsLabel.text = "\(timeInSeconds) s"
        imageView.image = UIImage(systemName: "\(podiumPosition).circle")
    }
    
    override func prepareForReuse() {
        userNameLabel.text = ""
        timeInSecondsLabel.text = ""
        recordDateLabel.text = ""
        imageView.image = nil
    }
}
