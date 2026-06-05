//
//  Asynchronous Sequences
//  Concurrency
//  https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Asynchronous-Sequences
//
//  Created by feed0 on 2026/05/29
//

import Foundation

// MARK: - AsyncSequence

let asyncArrayStream = AsyncStream<String> { continuation in
    for element in ["1", "2", "3", "4"] {
        continuation.yield(element)
    }
    continuation.finish()
}

// MARK: - Yield, sleep, yield

Task {
    for await line in asyncArrayStream {
        try await Task.sleep(for: .seconds(1))
        print("async stream:", line)
    }
}
