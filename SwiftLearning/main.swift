//
//  main.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 18.04.2023.
//

import Foundation

print("Hello, World!")


// Associated Values
enum Marks {
    case gpa(Double, Double, Double)
    case grade(String, String, String)
}

let gpa = Marks.gpa(1.1, 2.2, 3.3)
let grade = Marks.grade("11", "22", "33")


func getMark() -> Marks {
    Marks.gpa(1.1, 2.2, 3.3)
}

switch getMark() {
    case .gpa(let n1, let n2, let n3):
        print(n1, n2, n3)
    case .grade(let s1, let s2, let s3):
        print(s1, s2, s3)
}


enum SocialMediaPlatform {
    case twitter(followers: Int)
    case youtube(subscribers: Int)
    case instagram
    case linkedIn
}

func getSponsorshipEligibility(for platform: SocialMediaPlatform) {
    switch platform {
        case .twitter(let followers) where followers > 10_000:
            print("Eligible for sponsored Twitter")
        case .youtube(let subscribers) where subscribers > 20_000:
            print("Eligible for sponsored Youtube")
        default:
            print("Not eligible")
    }
}
