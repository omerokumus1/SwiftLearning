//
//  main.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 18.04.2023.
//

import Foundation

print("Hello, World!")


// ******************************************************************************************************************

// If a struct keeping reference of a class instance is copied by assigning,
// the class instance is not copied since it is a reference
// The same applies to enums since they are also value types

class Resolution {
    var width = 0
    var height = 0
}

struct VideoMode {
    // Class reference, will not be copied
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let resolution = Resolution()
var videoMode = VideoMode()
// Resolution assigned to videoMode
videoMode.resolution = resolution

// videoMode copied
var vm2 = videoMode

// class instance property is changed
vm2.resolution.width = 100

// struct property is changed
vm2.frameRate = 2.0

// struct property is changed
videoMode.frameRate = 1.0

// Will print 100, since it is a class instance
print(resolution.width)

// Will print 100, since it is a class instance
print(videoMode.resolution.width)

// Will print 1.0, since it is a struct instance
print(videoMode.frameRate)

// Will print 2.0, since it is a struct instance
print(vm2.frameRate)


// ******************************************************************************************************************

// If a class keeps an instance of a struct is assigned to another variable,
// the struct instance is copied since it is a value type.
// The same applies to enums since they are also value types




// ******************************************************************************************************************

// You can change properties of a class although it is defined via let
class MyClass {
    var classProp = ""
}

let myClass = MyClass()
myClass.classProp = "classProp"

// You can't change properties of a struct if it is defined via let
// It must be defined via var
struct MyStruct {
    var structProp = ""
}

let myStruct = MyStruct()
myStruct.structProp = "structProp"


