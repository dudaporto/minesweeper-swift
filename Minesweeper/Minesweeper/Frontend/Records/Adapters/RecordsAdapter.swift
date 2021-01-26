//
//  RecordsAdapter.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 16/09/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class RecordsAdapter: NSObject {
    let topOneSection = 0
    let commonRecordsSection = 1
    let orderedRecords: [Record]
    
    init(collectionView: UICollectionView, orderedRecords: [Record]) {
        self.orderedRecords = orderedRecords
    }
    
    private func registerCells(collectionView: UICollectionView) {
        collectionView.register(TopRecordCell.self, forCellWithReuseIdentifier: TopRecordCell.className)
        collectionView.register(RecordCell.self, forCellWithReuseIdentifier: RecordCell.className)
    }
}

extension RecordsAdapter: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case topOneSection:
            return 1
        case commonRecordsSection:
            return orderedRecords.count - 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let position = indexPath.item + indexPath.section
        let record = orderedRecords[indexPath.item + indexPath.section]
        
        switch indexPath.section {
        case topOneSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRecordCell.className, for: indexPath) as! TopRecordCell
            cell.setupCell(record: record, podiumPosition: position)
            return cell
            
        case commonRecordsSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordCell.className, for: indexPath) as! RecordCell
            cell.setupCell(record: record, podiumPosition: position)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension RecordsAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        .zero
//        switch section {
//        case topThreeSection:
//            return .zero
//        case commonRecordsSection:
//            return .zero
//        default:
//            return .zero
//        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        .zero
    }
}
