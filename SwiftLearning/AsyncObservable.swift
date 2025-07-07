//
//  AsyncObservable.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 7.07.2025.
//


import Foundation

// MARK: - Async Observable Generic Class
class AsyncObservable<T> {
    // You can make this queue configurable
    private let queue = DispatchQueue(label: "AsyncObservable")
    
    var value: T? {
        didSet {
            queue.sync {
                self.onValueChanged?(self.value)
            }
        }
    }
    
    var onValueChanged: ((T?) -> Void)?
    
}

// MARK: - 1-M Async Observable Generic Class
class AsyncObservable<T> {
    // You can make this queue configurable
    private let queue = DispatchQueue(label: "AsyncObservable")
    
    var value: T? {
        didSet {
            observers.forEach { observer in
                queue.async { [weak self] in // No guarantee for observer call order
                    observer(self?.value)
                }
            }
        }
    }
    
    // Store observers here
    private var observers: [(T?) -> Void] = []
    
    func addObserver(_ observer: @escaping (T?) -> Void) {
        observers.append(observer)
    }
    // Other functions...
}

// MARK: - 1-M Async Observable Generic Class
class AsyncObservable<T> {
    // You can make this queue configurable
    private let queue = DispatchQueue(label: "AsyncObservable")
    
    var value: T? {
        didSet {
            queue.async { [weak self] in // Guaranteed observer call order
                self?.observers.forEach { observer in
                    observer(self?.value)
                }
            }
        }
    }
    
    // Store observers here
    private var observers: [(T?) -> Void] = []
    
    func addObserver(_ observer: @escaping (T?) -> Void) {
        observers.append(observer)
    }
    // Other functions...
}

