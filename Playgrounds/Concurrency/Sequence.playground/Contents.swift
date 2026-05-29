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
