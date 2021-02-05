//
//  RecordsViewController.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 05/02/21.
//  Copyright © 2021 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class RecordsViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var visualEffectView: UIVisualEffectView!
    
    let easyRecords: [Record] = Record.mock.filter { $0.difficulty == .easy }
    let mediumRecords: [Record] = Record.mock.filter { $0.difficulty == .medium }
    let hardRecords: [Record] = Record.mock.filter { $0.difficulty == .hard }
    let colors: [UIColor] = [.systemGreen, .systemTeal, .systemBlue, .systemPurple, .systemPink]
    
    var currentPageRecords: [Record] {
        let segment = Game.Difficulty.allCases[segmentedControl.selectedSegmentIndex]
        
        switch segment {
        case .easy:
            return easyRecords
        case .medium:
            return mediumRecords
        case .hard:
            return hardRecords
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupSegmentedControl()
        
        collectionView.register(RecordCell.nib(), forCellWithReuseIdentifier: RecordCell.className)
        collectionView.register(TopRecordCell.nib(), forCellWithReuseIdentifier: TopRecordCell.className)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.contentInset.top = visualEffectView.frame.height
    }
    
    private func setupSegmentedControl() {
        Game.Difficulty.allCases.enumerated().forEach { (index, segment) in
            segmentedControl.setTitle(segment.title, forSegmentAt: index)
        }
    }
    
    private func setupNavigationBar() {
        title = "Records"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    @IBAction private func segmentedControlValueDidChange(_ sendey: Any) {
        collectionView.reloadData()
    }
    
    @IBAction private func deleteRecordsButtonClicked(_ sendey: Any) {
        print("TODO: Delete all records")
    }
}

extension RecordsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        currentPageRecords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRecordCell.className, for: indexPath) as! TopRecordCell
            cell.setup(with: currentPageRecords[indexPath.section])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordCell.className, for: indexPath) as! RecordCell
            cell.setup(with: currentPageRecords[indexPath.section], and: indexPath.section + 1)
            cell.color = colors[indexPath.section]
            return cell
        }
    }
}

extension RecordsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let height = indexPath.section == 0 ? TopRecordCell.height : RecordCell.height
        return CGSize(width: collectionView.frame.width, height: height)
    }
}
