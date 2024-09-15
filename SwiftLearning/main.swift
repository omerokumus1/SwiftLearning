//
//  main.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 18.04.2023.
//

import Foundation

print("Hello, World!")


func fetchHardwareStatus() {
    
}

func fetchSoftwareStatus() {
    
}

func fetchNetworkStatus() {
    
}

func openFile() {
    
}

func closeFile(_ file: Void) {
    
}



func writeLog() {
    let file = openFile()
    defer {
        closeFile(file)
    }
    
    let hardwareStatus = fetchHardwareStatus()
    guard hardwareStatus != "disaster" else { return }
    file.write(hardwareStatus)
    
    let softwareStatus = fetchSoftwareStatus()
    guard softwareStatus != "disaster" else { return }
    file.write(softwareStatus)
    
    let networkStatus = fetchNetworkStatus()
    guard neworkStatus != "disaster" else { return }
    file.write(networkStatus)
}

