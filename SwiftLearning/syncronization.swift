//
//  syncronization.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 8.08.2025.
//

import Foundation

let syncQueue = DispatchQueue(label: "syncQueue", attributes: .concurrent)
var sharedArray: [Int] = []

func barrierTest() {
    // Writer (using a barrier)
    func addItem(_ item: Int) {
        syncQueue.async(flags: .barrier) {
            print("✍️ Adding item \(item)...")
            sharedArray.append(item)
            print("✅ Item \(item) added")
        }
    }
    
    // Reader (normal concurrent reads)
    func readItems() {
        syncQueue.async {
            let items = sharedArray
            print("📖 Read: \(items)")
        }
    }
    
    readItems()       // Safe concurrent read
    addItem(1)        // Exclusive write
    readItems()       // Waits for the write to finish

}

func simulateBarrierMechanism() {
    print("\nSimulating barrier mechanism...")
    func log(_ message: String) {
        print("\(Date().timeIntervalSince1970): \(message)")
    }
    
    // Simulate two readers before the barrier
    syncQueue.async {
        log("🔵 Read Task A START")
        Thread.sleep(forTimeInterval: 2)
        log("🔵 Read Task A END")
    }
    
    syncQueue.async {
        log("🟢 Read Task B START")
        Thread.sleep(forTimeInterval: 2)
        log("🟢 Read Task B END")
    }
    
    // Barrier task
    syncQueue.async(flags: .barrier) {
        log("🛑 Barrier Task START")
        Thread.sleep(forTimeInterval: 3)
        log("✅ Barrier Task END")
    }
    
    // Two readers after the barrier
    syncQueue.async {
        log("🟣 Read Task C START")
        Thread.sleep(forTimeInterval: 1)
        log("🟣 Read Task C END")
    }
    
    syncQueue.async {
        log("🟠 Read Task D START")
        Thread.sleep(forTimeInterval: 1)
        log("🟠 Read Task D END")
    }
    
    Thread.sleep(forTimeInterval: 15)

}

let group = DispatchGroup()
let groupQueue = DispatchQueue.global(qos: .userInitiated)

func dispatchGroup() {
    for i in 1...3 {
        groupQueue.async(group: group) {
            print("🔄 Task \(i) started")
            Thread.sleep(forTimeInterval: Double(i)) // Simulate different durations
            print("✅ Task \(i) completed")
        }
    }
    
    // This is called when all tasks in the group have finished
    // notify function schedules a new task and does not wait for it to finish.
    group.notify(queue: groupQueue) {
        print("🎉 All tasks are done!")
    }
    // wait function blocks the current thread here until the group is finished
//    group.wait()
//    print("🎉 All tasks are done!")
    
//    let returned = group.wait(timeout: .now() + 2)
    
    Thread.sleep(forTimeInterval: 5)
}

