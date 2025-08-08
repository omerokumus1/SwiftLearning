//
//  qos.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 6.08.2025.
//

import Foundation

// -> Create a queue with qos defined
let qosQueue = DispatchQueue(label: "concurrentQueue",
                             qos: .userInitiated,
                             attributes: .concurrent)


func taskWithQos() {
    
    print("Tasks with individual QoS")
    qosQueue.async(qos: .background) {
        print("task with qos: .background")
    }
    
    qosQueue.async(qos: .utility) {
        print("task with qos: .utility")
    }
    
    qosQueue.async {
        print("task with qos of the qosQueue")
    }
    
}

func qosInheritance() {
    
    print("QoS Inheritance")
    qosQueue.async {
        print("task with qos of the qosQueue")
    }
    
    qosQueue.async(qos: .background) {
        print("task with qos .background")
        qosQueue.async {
            print("task with qos of the enclosing task: .background")
        }
    }
    
    qosQueue.async(qos: .background) {
        print("task with qos .background")
    }
    
    qosQueue.async(qos: .background) {
        print("task with qos .background")
        qosQueue.async(qos: .utility) {
            print("task with qos .utility")
        }
    }
    
}


func measureQoSExecution() {
    func start(qos: DispatchQoS.QoSClass, label: String) {
        let queue = DispatchQueue.global(qos: qos)
        
        let start = DispatchTime.now()
        queue.async {
            let end = DispatchTime.now()
            let elapsed = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000
            print("⏱️ [\(label)] started after \(elapsed) ms")
        }
    }
    
    print("Starting QoS performance test...\n")
    
    start(qos: .userInteractive, label: "User Interactive")
    start(qos: .userInitiated, label: "User Initiated")
    start(qos: .utility, label: "Utility")
    start(qos: .background, label: "Background")
}

func choosingQosDynamically() {
    func performHeavyWork() -> String {
        print("Performing heavy work...")
        return "Heavy data"
    }
    func updateUI(with data: String) {
        print("Updating UI with: \(data)")
    }
    func loadData(triggeredByUser: Bool) {
        let qos: DispatchQoS = triggeredByUser ? .userInitiated : .utility
        let queue = DispatchQueue.global(qos: qos.qosClass)
        
        queue.async {
            let data = performHeavyWork()
            DispatchQueue.main.async {
                updateUI(with: data)
            }
        }
    }
    
}
