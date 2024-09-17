//
//  main.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 18.04.2023.
//

import Foundation

let x: Any? = NSObject()

let arr = [1,2,nil]
print(type(of: arr))
for e in arr {
    print(type(of: e))
    print(e is Optional<Any>)
}

let arr2 = [1.0,2.0,nil]

//let r1 = [Int].filterNotNull(arr)
//print(r1)
//
let r2 = arr.filterNotNull()
print(r2)

let r3 = arr2.mapNotNull { $0*2 }

print(r3)

var b: Bool? = true
b.ifTrue { e in
    print("b is true")
}

b = false
b.ifTrue { e in
    print("b is true")
}

b.ifFalse { e in
    print("b is false")
}

b = nil
b.ifNil {
    print("b is nil")
}

b = true
b.ifNotNil { o in
    print("b is not nil")
}
