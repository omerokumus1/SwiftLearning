//
//  main.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 18.04.2023.
//

import Foundation

print("Hello, World!")

func repeating(times: Int, block: (Int) -> Void) {
    for i in 0..<times {
        block(i)
    }
}

repeating(times: 2) { i in
    print(i)
}

