//
//  RecordsManager.swift
//  Minesweeper
//
//  Created by Maria Eduarda Porto on 14/03/21.
//  Copyright © 2021 Maria Eduarda Porto. All rights reserved.
//

import Foundation

final class RecordsManager {
    enum RecordState {
        case bestScore
        case topFive
        case notElegible
    }
    
    static let shared = RecordsManager()
    
    private let maxRecordsPerDifficulty = 5
    private let recordsDirectoryURL = URL(
        fileURLWithPath: "Records",
        relativeTo: FileManager.documentDirectoryURL
    ).appendingPathExtension("json")
    
    private(set) var recordsStore: [DifficultyRecords] = []
    
    //MARK: - Public functions
    
    static func prepare() {
        _ = shared
    }
    
    func checkPossibleRecord(timeInSeconds: Int, difficulty: Game.Difficulty) -> RecordState {
        guard let difficultyRecordsIndex = getIndex(of: difficulty) else {
            return .notElegible
        }
        
        let records = recordsStore[difficultyRecordsIndex].records
        
        if let lastRecord = records.last, timeInSeconds > lastRecord.timeInSeconds {
            return .notElegible
        } else if let firstRecord = records.first, timeInSeconds < firstRecord.timeInSeconds {
            return .bestScore
        } else {
            return .topFive
        }
    }
    
    func addRecord(_ record: Record, difficulty: Game.Difficulty) {
        guard let difficultyRecordsIndex = getIndex(of: difficulty) else {
            return
        }
        
        recordsStore[difficultyRecordsIndex].records.append(record)
        recordsStore[difficultyRecordsIndex].records.sort()
        
        if recordsStore[difficultyRecordsIndex].records.count > maxRecordsPerDifficulty {
            let _ = recordsStore[difficultyRecordsIndex].records.removeLast()
        }
        
        saveRecords()
    }
    
    func deleteAllRecords() {
        recordsStore.enumerated().forEach({ (index, _) in
            recordsStore[index].records = []
        })
        
        saveRecords()
    }
    
    //MARK: - Private functions
    
    private init() {
        recordsStore = [
            DifficultyRecords(difficulty: .easy, records: []),
            DifficultyRecords(difficulty: .medium, records: []),
            DifficultyRecords(difficulty: .hard, records: [])
        ]
        
        loadRecords()
    }
    
    private func getIndex(of difficuly: Game.Difficulty) -> Array<DifficultyRecords>.Index? {
        let index = recordsStore.firstIndex(where: {
            $0.difficulty == difficuly
        })
        
        return index
    }

    private func loadRecords() {
        let decoder = JSONDecoder()
            
        do {
            let recordsData = try Data(contentsOf: recordsDirectoryURL)
            recordsStore = try decoder.decode([DifficultyRecords].self, from: recordsData)
        } catch let error {
            print(error)
        }
    }
    
    private func saveRecords() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let recordsData = try encoder.encode(recordsStore)
            try recordsData.write(to: recordsDirectoryURL, options: .atomicWrite)
        } catch let error {
            print(error)
        }
    }
}
