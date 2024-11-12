//
//  main.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 18.04.2023.
//

import Foundation

@propertyWrapper
struct Cached {
    private var cachedValue: String? = nil
    var projectedValue: Cached { return self }
    
    var wrappedValue: String? {
        get { cachedValue }
        set { cachedValue = newValue }
    }
    
}

struct CachedExample {
    @Cached var prop: String? = "cached value"
}

var cachedExample = CachedExample()
cachedExample.$prop.invalidate()
