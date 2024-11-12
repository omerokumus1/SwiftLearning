//
//  main.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 18.04.2023.
//

import Foundation

class SubscriptExample {
    private var elements: [Int] = [1,2,3]
    
    subscript(index: Int) -> Int {
        get {
            elements[index]
        }
        
        set(newValue) {
            elements[index] = newValue
        }
    }
}

let subscriptEx = SubscriptExample()
subscriptEx[0] = 100
print(subscriptEx[0])


struct ReadOnlySubscriptExample {
    private var logs = ["Initial Log"]
    
    subscript(index: Int) -> String? {
        get {
            if index >= 0 && index < logs.count {
                logs[index]
            } else {
                nil
            }
        }
    }
}

let readOnlySubscriptEx = ReadOnlySubscriptExample()
print(readOnlySubscriptEx[0])
// Error: subscript is get-only
// readOnlySubscriptEx[0] = "New Log"


struct SubscriptParameterTypesExample {
    private var matrix = ["Person1": "Salary1", "Person2": "Salary2"]
    
    subscript(key: String) -> String? {
        get {
            matrix[key]
        }
        
        set(newValue) {
            if matrix.keys.contains(where: { $0 == key }){
                matrix[key] = newValue
            }
        }
    }
}

var subscriptParameterTypesExample = SubscriptParameterTypesExample()
print(subscriptParameterTypesExample["Person1"]) // Optional("Salary1")
subscriptParameterTypesExample["Person1"] = "New Salary"
subscriptParameterTypesExample["Person3"] = "No Salary"
print(subscriptParameterTypesExample["Person1"]) // Optional("New Salary")
print(subscriptParameterTypesExample["Person3"]) // nil


struct SubscriptParameterListSizeExample {
    private var matrix = [
        [1,10],
        [2,20],
        [3,30],
    ]
    
    subscript(row: Int, column: Int) -> Int? {
        get {
            if row < matrix.count && column < matrix[0].count {
                matrix[row][column]
            } else {
                nil
            }
        }
        set(newValue) {
            if row < matrix.count && column < matrix[0].count {
                if let newValue = newValue {
                    matrix[row][column] = newValue
                }
            }
        }
        
    }
}

var subscriptParameterListSizeEx = SubscriptParameterListSizeExample()
print(subscriptParameterListSizeEx[0,0]) // Output: Optional(1)
subscriptParameterListSizeEx[0, 0] = 11
print(subscriptParameterListSizeEx[0,0]) // Output: Optional(11)
print(subscriptParameterListSizeEx[10,10]) // Output: nil
                                           // Does not set
subscriptParameterListSizeEx[10, 10] = 11


struct OverloadingSubscriptExample {
    private var elements = [1,2,3]
    private var matrix = [
        [1,10],
        [2,20],
        [3,30],
    ]
    
    subscript(index: Int) -> Int? {
        get {
            if index >= 0 && index < elements.count {
                elements[index]
            } else {
                nil
            }
        }
        set(newValue) {
            if let newValue = newValue,
               index >= 0 && index < elements.count {
                elements[index] = newValue
            }
        }
    }
    
    subscript(row: Int, column: Int) -> Int? {
        get {
            if row < matrix.count && column < matrix[0].count {
                matrix[row][column]
            } else {
                nil
            }
        }
        set(newValue) {
            if row < matrix.count && column < matrix[0].count {
                if let newValue = newValue {
                    matrix[row][column] = newValue
                }
            }
        }
        
    }
}


enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)
