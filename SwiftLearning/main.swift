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


// MARK: - Observable Generic Class
//var nameObservable = Observable<String>()
//nameObservable.onValueChanged = { value in
//    print("Value changed to: \(value)")
//}
//nameObservable.value = "Hello, World!"
//
//
//print()


// MARK: - 1-M Observable Generic Class
var nameObservable = Observable<String>()
nameObservable.addObserver { value in
    print("Observer 1 - Value: \(value)")
}
nameObservable.addObserver { value in
    print("Observer 2 - Value: \(value)")
}

nameObservable.value = "Hello!" // prints: Observer 1 - Value: Hello!
                                        // Observer 2 - Value: Hello!


print()


// MARK: - Observable Property Wrapper
class ViewModel {
    @ObservableValue var name: String = ""
    @ObservableValue var age: Int = 0
}


let vm = ViewModel()

// Subscribe to changes
vm.$name.observe { newName in
    print("Name changed to: \(newName)")
}

vm.$age.observe { newAge in
    print("Age changed to: \(newAge)")
}

// Trigger changes
vm.name = "Ömer"  // Prints: Name changed to: Ömer
vm.age = 30       // Prints: Age changed to: 30



// MARK: - Async Observables


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
