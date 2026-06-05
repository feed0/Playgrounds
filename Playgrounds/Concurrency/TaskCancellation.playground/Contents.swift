//
//  Task Cancellation
//  Concurrency
//  https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Task-Cancellation
//
//  Created by feed0 on 2026/06/05
//

import Foundation

// 1. Store the task reference!
let task = Task {
    
    let photos = await withTaskGroup(of: String?.self) { group in
        
        // MARK: Child tasks
        
        for name in photoNames {
            
            // 2. Cancell it if there is an interruption!
            if name == "CANCEL" {
                task.cancel()
                print("CANCELLED!")
            }
            
            let added = group.addTaskUnlessCancelled {
                Task.isCancelled ? nil : await downloadPhoto(named: name)
            }
            
            // 3. Break out after an interruption!
            guard added else { break }
        }
        
        // MARK:  Async group
        
        var results: [String] = []
        for await photo in group {
            print(Date.now.formatted(date: .omitted, time: .standard), terminator: " . ") /// print time for each task return
            
            if let photo {
                print(photo)
                results.append(photo)
            }
        }
        
        // MARK: Return successful results
        
        print("\n\(results.debugDescription)")
        return results
    }
}

// MARK: - Properties and functions

let photoNames = [
    "a", "b", "c", "CANCEL", "d" // "d" will never be printed from the for name loop
]

func downloadPhoto(named name: String) async -> String {
    do {
        try await Task.sleep(for: .seconds(1))
    } catch {
        /// not implemented
    }
    
    return photoNames.first { $0 == name } ?? "."
}
