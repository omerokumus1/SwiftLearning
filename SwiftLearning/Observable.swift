//
//  Observable.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 7.07.2025.
//

import Foundation

// MARK: - Observable Generic Class
//class Observable<T> {
//    var value: T? = nil {
//        didSet { // didSet Property Observer helps us to achieve observablity
//            onValueChanged?(value) // Call the closure after value changed
//        }
//    }
//    
//    // Closure to call after value changed
//    var onValueChanged: ((T?) -> Void)?
//    
//}

// MARK: - 1-M Observable Generic Class
// Generic class that holds the value and observers
class Observable<T> {
    var value: T? = nil {
        didSet { // didSet Property Observer helps us to achieve observablity
            observers.forEach { $0(value) } // Notify observers
        }
    }
    
    // Array to hold observers as closures
    private var observers: [(T?) -> Void] = []
    
    // Function to add observers
    func addObserver(_ observer: @escaping (T?) -> Void) {
        observers.append(observer)
    }
    // Other functions...
}

@propertyWrapper
class ObservableValue<T> {
    private var value: T
    private var observers: [(T) -> Void] = []
    
    var wrappedValue: T {
        get { value }
        set {
            value = newValue
            notifyObservers()
        }
    }
    
    // To access functions of this class
    var projectedValue: ObservableValue<T> { self }
    
    init(wrappedValue: T) {
        self.value = wrappedValue
    }
    
    /// Adds an observer closure that will be called when the value changes
    func observe(_ observer: @escaping (T) -> Void) {
        observers.append(observer)
    }
    
    private func notifyObservers() {
        observers.forEach { $0(value) }
    }
}


// MARK: - Observable with Observer Protocol

//protocol Observer: AnyObject {
//    associatedtype Value
//    func onValueChanged(_ value: Value?)
//}
//

//// MARK: - Observable Generic Class with Observer Protocol
//class Observable<T> {
//    var value: T? = nil {
//        didSet {
//            self.observer?.onValueChanged(value)
//        }
//    }
//    private weak var observer: (any Observer<Value = T>)?
//
//}
//
//// MARK: - 1-M Observable Generic Class with Observer Protocol
//class Observable<T> {
//    var value: T? = nil {
//        didSet {
//            observers.forEach { $0(value) }
//        }
//    }
//
//    private var observers: [(T?) -> Void] = []
//
//    func addObserver(_ observer: @escaping (T?) -> Void) {
//        observers.append(observer)
//    }
//    // Other functions...
//}
