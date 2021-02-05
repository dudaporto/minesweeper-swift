//
//  RecordsViewController.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 05/02/21.
//  Copyright © 2021 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class RecordsViewController: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    let records: [Record] = Record.mock
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(RecordCell.nib(), forCellWithReuseIdentifier: RecordCell.className)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension RecordsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        records.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordCell.className, for: indexPath) as! RecordCell
        cell.configure(with: records[indexPath.section])
        return cell
    }
}

extension RecordsViewController: UICollectionViewDelegateFlowLayout {

}
