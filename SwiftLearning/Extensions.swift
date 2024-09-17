//
//  HOFs.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 15.09.2024.
//

import Foundation

extension Array {
    
    static func filterNotNull<T>(_ arr: [T?]) -> [T] {
        var result: [T] = []
        for e in arr {
            if e != nil { result.append(e!) }
        }
        return result
    }
    
}

protocol OptionalType {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: OptionalType {
    var value: Wrapped? {
        return self
    }
}


extension Array where Element: OptionalType {
    func filterNotNull() -> [Element.Wrapped] {
        var result = [Element.Wrapped]()
        for item in self {
            if let unwrapped = item.value {
                result.append(unwrapped)
            }
        }
        return result
    }
}
