//
//  main.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 18.04.2023.
//

import Foundation

//MARK: - CustomDebugStringConvertible


struct User: CustomDebugStringConvertible {
    var id: Int
    var username: String
    var password: String // sensitive, shouldn't show in debug
    
    var debugDescription: String { // You have to prvovide this
        return "User(id: \(id), username: \(username))"
    }
}

let user = User(id: 1, username: "Ömer", password: "secret123")
print(user)      // Prints: User(id: 1, username: omerdev)

print()

// MARK: - debugPrint
// Better for sensitive data that shouldn't show in debug becuase print fallbacks
debugPrint(user) // Prints: User(id: 1, username: omerdev)
print(user)      // Prints: User(id: 1, username: omerdev) (fallbacks if CustomStringConvertible not implemented)

// MARK: - print Fallback

