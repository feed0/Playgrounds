//
//  Task sleep
//  Concurrency
//  https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Defining-and-Calling-Asynchronous-Functions
//
//  Created by feed0 on 2026/05/28
//

// MARK: - Definition

func asyncPrint(_ string: String) async throws {
    
    /// Sleep
    try await Task.sleep(for: .seconds(1))
    print("1 sec")
    
    try await Task.sleep(for: .seconds(1))
    print("2 secs")
    
    /// Finally
    print(string)
}

// MARK: - Call

Task {
    do {
        try await asyncPrint("End")
    } catch {
        /// not implemented
    }
}
