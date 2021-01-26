//
//  RecordsViewController.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 16/09/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class RecordsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var adapter: RecordsAdapter = {
        return RecordsAdapter(collectionView: collectionView, orderedRecords: Record.mock)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
    }
}
