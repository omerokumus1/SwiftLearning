//
//  Observable.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 7.07.2025.
//

import Foundation

// MARK: - Observable Generic Class
class Observable<T> {
    var value: T? = nil {
        didSet { // didSet Property Observer helps us to achieve observablity
            onValueChanged?(value) // Call the closure after value changed
        }
    }
    
    // Closure to call after value changed
    var onValueChanged: ((T?) -> Void)?
    
}

// MARK: - 1-M Observable Generic Class
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


//protocol Observer: AnyObject {
//    associatedtype Value
//    func onValueChanged(_ value: Value?)
//}
//
//// MARK: - Observable Generic Class
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
//// MARK: - 1-M Observable Generic Class
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
