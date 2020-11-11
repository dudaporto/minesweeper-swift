//
//  RecordsAdapter.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 16/09/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class RecordsAdapter: NSObject {
    let topThreeSection = 0
    let commonRecordsSection = 1
    let orderedRecords: [Record]
    
    init(collectionView: UICollectionView, orderedRecords: [Record]) {
        self.orderedRecords = orderedRecords
    }
}

extension RecordsAdapter: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case topThreeSection:
            return 3
        case commonRecordsSection:
            return orderedRecords.count - 3
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension RecordsAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch section {
        case topThreeSection:
            return .zero
        case commonRecordsSection:
            return .zero
        default:
            return .zero
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        <#code#>
    }
}
