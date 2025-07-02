//
//  main.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 18.04.2023.
//

import Foundation

//MARK: - Function Arguments are Immutable
// ❌ Does not work
//func removeInitial(_ str: String) -> String {
//    // The following line gives the error;
//    // Cannot use mutating member on immutable value: 'str' is a 'let' constant
//    str.remove(at: str.startIndex)
//    return str
//}

// ✅ Solution
func removeInitial(_ str: String) -> String {
    var str = str // Copy the element as 'var'
    str.remove(at: str.startIndex)
    return str
}

//MARK: - Arrays are Value Type

var arr1 = [1, 2, 3]
var arr2 = arr1 // Copies arr1
arr2.append(4)
print(arr1) // Prints [1, 2, 3]
print(arr2) // Prints [1, 2, 3, 4]

func mutateArray(_ arr: [Int]) -> [Int] {
    // Function args are immutable, so you cant change them
    // This is the trick to make them mutable
    var arrCopy = arr // Copies arr, since arr is a value type
    arrCopy.append(0)
    return arrCopy
}

var arr = [1, 2, 3]
arr = mutateArray(arr)
print(arr) // prints [1, 2, 3, 0]
print()

