//
//  main.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 18.04.2023.
//

import Foundation

class Test : Equatable {
    let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    static func == (lhs: Test, rhs: Test) -> Bool {
        lhs.name == rhs.name
    }
}

let t1 = Test("t1")
let t2 = Test("t2")

print(t1 == t2)


struct STest : Equatable {
    let name: String
    
}

let s1 = STest(name: "s1")
let s2 = STest(name: "s2")

print(s1 == s2)

enum ETest {
case name
}

let e1 = ETest.name
let e2 = ETest.name

print(e1 == e2)

