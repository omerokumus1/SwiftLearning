//
//  SimpleObservable.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 3.07.2025.
//

import Foundation

class StringObservable {
    private var value: String? // Encapsulation by private
    
    var onValueChanged: ((String) -> Void)? // Closure to call after value changed
    
    // Setter since we applied Encapsulation
    func setValue(_ newValue: String?) {
        self.value = newValue // Set value
        onValueChanged?(newValue ?? "") // Call closure
    }
    
    // Getter since we applied Encapsulation
    func getValue() -> String? {
        return value
    }
}
