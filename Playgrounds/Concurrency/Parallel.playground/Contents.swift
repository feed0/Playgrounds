//
//  Calling Asynchronous Functions in Parallel
//  Concurrency
//  https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Calling-Asynchronous-Functions-in-Parallel
//
//  Created by feed0 on 2026/06/02
//

import Foundation

print()

Task {
    
    // MARK: - Serial prints
    
    let firstPhoto = await downloadPhoto(named: "a") /// wait 1 second
    let secondPhoto = await downloadPhoto(named: "b") /// wait +1 second
    let thirdPhoto = await downloadPhoto(named: "c") /// wait +1 second
    
    let serialArray = [firstPhoto, secondPhoto, thirdPhoto]
    
    print(serialArray.debugDescription)
    
    // MARK: - Parallel prints
    
    async let fourthPhoto = downloadPhoto(named: "X")
    async let fifthPhoto = downloadPhoto(named: "Y")
    async let sixthPhoto = downloadPhoto(named: "Z")
    
    let parallelArray = await [fourthPhoto, fifthPhoto, sixthPhoto] /// wait 1 second
    
    print(parallelArray.debugDescription)
}

// MARK: - Properties and functions

let photoNames = [
    "a", "b", "c", /// serial task
    "X", "Y", "Z", /// parallel task
]

func downloadPhoto(named name: String) async -> String {
    do {
        try await Task.sleep(for: .seconds(1))
    } catch {
        /// not implemented
    }
    
    print(Date.now.formatted(date: .omitted, time: .standard), terminator: " ") /// print time for each call
    
    return photoNames.first { $0 == name } ?? "."
}
