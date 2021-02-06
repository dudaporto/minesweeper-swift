//
//  EmptyRecordsCell.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 05/02/21.
//  Copyright © 2021 Maria Eduarda Porto. All rights reserved.
//

import UIKit

protocol EmptyRecordsCellDelegate: class {
    func emptyRecordsCellPlayButtonClicked(_ cell: EmptyRecordsCell)
}

class EmptyRecordsCell: UICollectionViewCell {

    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var playButton: UIButton!
    
    weak var delegate: EmptyRecordsCellDelegate?
    
    var color: UIColor? {
        didSet {
            guard let color = color else {
                return
            }
            
            messageLabel.textColor = color
            playButton.borderColor = color
            playButton.setTitleColor(color, for: .normal)
        }
    }
    
    @IBAction private func playButtonClicked(_ sender: Any) {
        delegate?.emptyRecordsCellPlayButtonClicked(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
