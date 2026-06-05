//
//  Tasks and Task groups
//  Concurrency
//  https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Tasks-and-Task-Groups
//
//  Created by feed0 on 2026/06/03
//

import Foundation

Task {
    await withTaskGroup(of: String.self) { group in
        
        // MARK: Child tasks
        
        for name in photoNames {
            group.addTask {
                return await downloadPhoto(named: name)
            }
        }
        
        // MARK: Async group
        
        for await photo in group {
            print(Date.now.formatted(date: .omitted, time: .standard), terminator: " . ") /// print time for each task return
            print(photo)
        }
    }
}

// MARK: - Properties and functions

let photoNames = [
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
    // TODO: keep adding photo names
]

func downloadPhoto(named name: String) async -> String {
    do {
        try await Task.sleep(for: .seconds(1))
    } catch {
        /// not implemented
    }
    
    return photoNames.first { $0 == name } ?? "."
}
