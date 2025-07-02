//
//  main.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 18.04.2023.
//

import Foundation

//MARK: - dump() Function
//let fruits = ["Orange", "Banana", "Apple", "Mango", "Pineapple"]
//dump(fruits)

let fruits = ["Portakal", "Muz", "Elma", "Mango", "Ananas"]
dump(fruits)

print()

// MARK: - dump() Function 2
struct User {
    let id: Int
    let name: String
    let isActive: Bool
}

let user = User(id: 1, name: "Ömer", isActive: true)

dump(user)

print()
