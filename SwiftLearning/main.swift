//
//  main.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 18.04.2023.
//

import Foundation

print("Hello, World!")


// let and var on properties
struct MyStruct {
    var v1: String = ""
    let v2: Int = 0
}

class MyClass {
    var v1: String = ""
    let v2: Int = 0
}

let s1 = MyStruct()
let c1 = MyClass()

// s1.v1 = "new" // Error bc struct is defined via let
c1.v1 = "new"


// Inheritance for Property Observers
class Parent {
    var prop: String = "" {
        willSet {
            print("prop willSet in Parent called")
        }
        didSet {
            print("prop didSet in Parent called")
        }
    }
    
}

class Child : Parent {
    override var prop: String {
        willSet {
            print("prop willSet in Child called")
        }
        didSet {
            print("prop didSet in Child called")
        }
    }
}

let child = Child()
child.prop = "new prop"
