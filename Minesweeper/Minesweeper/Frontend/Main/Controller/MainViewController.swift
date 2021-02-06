//
//  MainViewController.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 22/08/20.
//  Copyright © 2020 Maria Eduarda Porto. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    private let showGameViewControllerSegueId = "showGameViewController"
    private let showRecordsViewController = "showRecordsViewController"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case showRecordsViewController:
            guard let viewController = segue.destination as? RecordsViewController else {
                return
            }
            
            viewController.delegate = self
            
        default:
            break
        }
        
    }
}

extension MainViewController: RecordsViewControllerDelegate {
    func recordsViewControllerPlayButtonClicked(_ viewController: RecordsViewController) {
        navigationController?.popViewController(animated: true)
        performSegue(withIdentifier: self.showGameViewControllerSegueId, sender: nil)
    }
}
