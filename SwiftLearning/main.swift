//
//  main.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 18.04.2023.
//

import Foundation

// Global Computed Variables
var currentDateTime: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    return formatter.string(from: Date())
}

print(currentDateTime)

// Global Read-Only Computed Variables
var pi: Double {
    return 3.14159
}

// Global Read-Write Computed Variables
var temperatureInCelsius: Double = 20.0

var temperatureInFahrenheit: Double {
    get {
        return (temperatureInCelsius * 9 / 5) + 32
    }
    set {
        temperatureInCelsius = (newValue - 32) * 5 / 9
    }
}

