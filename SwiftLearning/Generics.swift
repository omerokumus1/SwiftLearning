//
//  Generics.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 17.09.2024.
//

import Foundation

func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}



/// Associated Types
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
    // original IntStack implementation
    var items: [Int] = []
    mutating func push(_ item: Int) { items.append(item) }
    mutating func pop() -> Int { return items.removeLast() }

    // conformance to the Container protocol
    
    // Not needed
//    typealias Item = Int
    
    mutating func append(_ item: Int) { self.push(item) }
    
    var count: Int { return items.count }
    
    subscript(i: Int) -> Int { return items[i] }
    
}

extension Optional {

}

extension Array {
    func filterNotNull<T>() -> [T] where Element == Optional<T> {
        var result: [T] = []
        for e in self {
            if let element = e { result.append(element) }
        }
        return result
    }
    
    func mapNotNull<T, R>(transform: (T) -> R) -> [R] where Element == Optional<T> {
        var result: [R] = []
        for e in self {
            if let element = e { result.append(transform(element)) }
        }
        return result
    }
}

extension Optional {
    func ifNil(block: () -> Void) {
        guard let _ = self else { block(); return; }
    }
    
    func ifNotNil(block: (Wrapped) -> Void) {
        if let w = self {
            block(w)
        }
    }
    
    func ifNilGet<T>(_ item: T) -> T? {
        if self == nil { return item }
        return nil
    }
    
    func ifNotNilGet<T>(_ item: T) -> T? {
        if self != nil { return item }
        return nil
    }
    
}

extension Optional where Wrapped == Bool {
//    func ifTrue(block: (Bool) -> Void) {
//        if let bool = self, bool == true { block(bool) }
//    }
//    
//    func ifFalse(block: (Bool) -> Void) {
//        if let bool = self, bool == false { block(bool) }
//    }
    
}

extension Bool? {
    func ifTrue(block: (Bool) -> Void) {
        if let w = self, w == true { block(w) }
    }
    
    func ifFalse(block: (Bool) -> Void) {
        if let w = self, w == false { block(w) }
    }
}

extension Bool {
    func ifTrue(block: (Bool) -> Void) {
        if self == true { block(self) }
    }
    
    func ifFalse(block: (Bool) -> Void) {
        if self == false { block(self) }
    }
    
    func ifTrueGet<T>(_ item: T) -> T? {
        if self == true { return item }
        return nil
    }
    
    func ifFalseGet<T>(_ item: T) -> T? {
        if self == false { return item }
        return nil
    }
    
}
