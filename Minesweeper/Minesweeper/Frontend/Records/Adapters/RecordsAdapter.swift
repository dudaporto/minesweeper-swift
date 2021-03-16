//
//  RecordsAdapter.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 05/02/21.
//  Copyright © 2021 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class RecordsAdapter: NSObject {
    private enum Section: Int {
        case emptyState
        case records
    }
    
    var difficultyRecords: DifficultyRecords!
    weak var emptyRecordsDelegate: EmptyRecordsCellDelegate?
    
    init(collectionView: UICollectionView) {
        super.init()
        self.registerCells(collectionView: collectionView)
    }
    
    private func registerCells(collectionView: UICollectionView) {
        collectionView.register(EmptyRecordsCell.nib(), forCellWithReuseIdentifier: EmptyRecordsCell.className)
        collectionView.register(RecordCell.nib(), forCellWithReuseIdentifier: RecordCell.className)
        collectionView.register(TopRecordCell.nib(), forCellWithReuseIdentifier: TopRecordCell.className)
    }
}

extension RecordsAdapter: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .emptyState:
            return difficultyRecords.records.isEmpty ? 1 : 0
            
        case .records:
            return difficultyRecords.records.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        switch section {
        case .emptyState:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: EmptyRecordsCell.className,
                for: indexPath
            ) as! EmptyRecordsCell
            
            cell.color = difficultyRecords.difficulty.color
            cell.delegate = emptyRecordsDelegate
            return cell
            
        case .records:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TopRecordCell.className,
                    for: indexPath
                ) as! TopRecordCell
                
                cell.setup(with: difficultyRecords.records[indexPath.item])
                return cell
                
            default:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: RecordCell.className,
                    for: indexPath
                ) as! RecordCell
                
                cell.setup(with: difficultyRecords.records[indexPath.item], and: indexPath.item + 1)
                cell.color = difficultyRecords.difficulty.color
                return cell
            }
        }
    }
}

extension RecordsAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout: UICollectionViewLayout,
        insetForSectionAt: Int
    ) -> UIEdgeInsets {
        .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let section = Section(rawValue: indexPath.section) else {
            return .zero
        }
        
        switch section {
        case .emptyState:
            let height = collectionView.frame.height - collectionView.contentInset.top
            return CGSize(width: collectionView.frame.width, height: height)
            
        case .records:
            let height = indexPath.item == 0 ? TopRecordCell.height : RecordCell.height
            return CGSize(width: collectionView.frame.width, height: height)
        }
    }
}
