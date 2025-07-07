//
//  main.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 18.04.2023.
//

import Foundation


// MARK: - Simple Observable with Closures
var onNameChanged: ((String) -> Void)? // Closure to call after value changed

var name = "" {
    didSet { // didSet Property Observer helps us to achieve observablity
        onNameChanged?(name) // Call the closure after value changed
    }
}

onNameChanged = { newName in
    print("Name changed to: \(newName)")
}

name = "Ömer" // Setting this triggers didSet then onNameChanged,
              // thus, prints "Name changed to: Ömer"

print()

// MARK: - StringObservable
let stringObservable = StringObservable()
stringObservable.onValueChanged = { value in
    print("Value changed to: \(value)")
}

stringObservable.setValue("DrMobileDev")

print()

// MARK: - SingleObservable
//let singleObservable = SingleObservable<String>()
//singleObservable.onValueChanged = { value in
//    print("Value changed to: \(value)")
//}
//
//singleObservable.value = "Hello, World!"
//singleObservable.value = nil
//
//
//print()

// MARK: - Async Observable with Closures
var onValueChanged: ((Int?) -> Void)? // Closure to call after value changed
var value: Int? {
    didSet { // didSet Property Observer helps us to achieve observablity
        DispatchQueue.global(qos: .default).async { // Set qos as you wish
            onValueChanged?(value) // Call the closure after value changed
        }
    }
}

onValueChanged = { newValue in
    print("Value changed to: \(newValue)")
}

value = 24 // Setting this triggers didSet then onNameChanged,
           // thus, prints "Value changed to: 24"


print()
Thread.sleep(forTimeInterval: 2)


// MARK: - Observable Generic Class
var nameObservable = Observable<String>()
nameObservable.onValueChanged = { value in
    print("Value changed to: \(value)")
}
nameObservable.value = "Hello, World!"


print()
