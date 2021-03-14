//
//  RecordsViewController.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 05/02/21.
//  Copyright © 2021 Maria Eduarda Porto. All rights reserved.
//

import UIKit

protocol RecordsViewControllerDelegate: class {
    func recordsViewControllerPlayButtonClicked(_ viewController: RecordsViewController)
}

class RecordsViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var visualEffectView: UIVisualEffectView!
    
    var allRecords: [Record] = []// Record.mock
    var currentSelectedDifficulty: Game.Difficulty {
        Game.Difficulty.allCases[segmentedControl.selectedSegmentIndex]
    }
    
    weak var delegate: RecordsViewControllerDelegate?
    
    private lazy var adapter: RecordsAdapter = {
       return RecordsAdapter(collectionView: collectionView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAdapter()
        setupNavigationBar()
        setupDifficultyColor()
        setupSegmentedControl()
        
        collectionView.delegate = adapter
        collectionView.dataSource = adapter
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.contentInset.top = visualEffectView.frame.height
    }
    
    private func setupAdapter() {
        adapter.emptyRecordsDelegate = self
        
        adapter.records[.easy] = []
        adapter.records[.medium] = []
        adapter.records[.hard] = []
        
        allRecords.forEach({ record in
            adapter.records[record.difficulty]?.append(record)
        })
    }
    
    private func setupNavigationBar() {
        title = NSLocalizedString("records_title", comment: "")
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setupSegmentedControl() {
        Game.Difficulty.allCases.enumerated().forEach { (index, segment) in
            segmentedControl.setTitle(segment.title, forSegmentAt: index)
        }
    }
    
    private func setupDifficultyColor() {
        navigationController?.navigationBar.tintColor = currentSelectedDifficulty.color
        navigationItem.rightBarButtonItem?.tintColor = currentSelectedDifficulty.color
    }
    
    @IBAction private func segmentedControlValueDidChange(_ sendey: Any) {
        setupDifficultyColor()
        adapter.currentDifficulty = currentSelectedDifficulty
        collectionView.reloadData()
    }
    
    @IBAction private func deleteRecordsButtonClicked(_ sendey: Any) {
//        guard !allRecords.isEmpty else {
//            return
//        }
        
        let alert = UIAlertController(
            title: NSLocalizedString("records_delete_alert_title", comment: ""),
            message: NSLocalizedString("records_delete_alert_message", comment: ""),
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("records_delete_alert_negative_option", comment: ""),
                style: .destructive)
        )
        
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("records_delete_alert_positive_option", comment: ""),
                style: .default,
                handler: { _ in
                    print("TODO: Delete all records")
                }
            )
        )
        
        present(alert, animated: true)
    }
}

extension RecordsViewController: EmptyRecordsCellDelegate {
    func emptyRecordsCellPlayButtonClicked(_ cell: EmptyRecordsCell) {
        DifficultyManager.saveSeletedDifficulty(currentSelectedDifficulty)
        delegate?.recordsViewControllerPlayButtonClicked(self)
    }
}
