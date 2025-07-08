//
//  main.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 18.04.2023.
//

import Foundation

// MARK: - DispatchQueue
// ----------------------------------------- Serial DispatchQueue -----------------------------------------
// - Serial DispatchQueue: FIFO, Single Thread - One Task at a Time, Thread-Safe

let serialQueue = DispatchQueue(label: "serialQueue")
serialQueue.async { print("serialQueue 1 Thread: \(Thread.current)") }
serialQueue.async { print("serialQueue 2 Thread: \(Thread.current)") }
serialQueue.async { print("serialQueue 3 Thread: \(Thread.current)") }


Thread.sleep(forTimeInterval: 1)

/* Use Cases for Serial Queues
 - Accessing Shared Mutable State
    When multiple tasks need to read and write to the same data, a serial queue can prevent data corruption by ensuring that only one task accesses the data at a time.
 
 - Performing Sequential Operations
    If tasks must be executed in a specific order, a serial queue guarantees that order is maintained.
 
 - Synchronizing Resources for Thread Safety
    Serial queues can be used to synchronize access to resources like files, databases, or hardware devices.
 
 */

// Ex: Accessing Shared Mutable State
var arr = [1,2,3,4,5]
print(arr)
serialQueue.async {
    let r = Int.random(in: 0..<100)
    let i = Int.random(in: 0..<arr.count)
    print("Async 1 removes \(arr[i]) at \(i) and adds \(r)")
    arr.remove(at: i)
    arr.append(r)
    
    print(arr)
    print()
}

serialQueue.async {
    let r = Int.random(in: 0..<100)
    let i = Int.random(in: 0..<arr.count)
    print("Async 2 removes \(arr[i]) at \(i) and adds \(r)")
    arr.remove(at: i)
    arr.append(r)
    
    print(arr)
    print()
}

serialQueue.async {
    let r = Int.random(in: 0..<100)
    let i = Int.random(in: 0..<arr.count)
    print("Async 2 removes \(arr[i]) at \(i) and adds \(r)")
    arr.remove(at: i)
    arr.append(r)
    
    print(arr)
    print()
}

// * Searial Queue is most important in a Concurrent environment to sync shared resource access

/* Serial Queue Common Pitfalls
 - Deadlock via sync on same queue
    Calling serialQueue.sync { … } from within a task already running on serialQueue will hang forever.
 
 - Unintentional serialization
    If you use a single serial queue for unrelated tasks, total execution time is increased redundantly
 
 - Blocking the queue
    Long‑running work inside a serial queue can starve subsequent tasks.
 */

/* Serial Queue Best Practices
 - Favor async + completion handlers over sync to avoid deadlock.
 - Use multiple serial queues if you have distinct resource domains (e.g., cacheQueue, databaseQueue).
 - Keep each task lightweight: Offload heavy work (compute, I/O) to background concurrent queues when ordering isn’t critical.
 */



// ----------------------------------------- Concurrent DispatchQueue -----------------------------------------
// - Concurrent DispatchQueue: started in FIFO but not guaranteed order of completion | Multiple Threads | Race Conditions
let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)

concurrentQueue.async { print("concurrentQueue 1 Thread: \(Thread.current)") }
//Thread.sleep(forTimeInterval: 1) // Without this, all three async runs on 3 different threads. Adding this reuses one of the threads
concurrentQueue.async { print("concurrentQueue 2 Thread: \(Thread.current)") }
concurrentQueue.async { print("concurrentQueue 3 Thread: \(Thread.current)") }


Thread.sleep(forTimeInterval: 1)

/* Use Cases for Concurrent Queues
 - Performing Independent Tasks
    When tasks don't depend on each other and don't access shared mutable state, a concurrent queue can significantly improve performance by executing them in parallel.
 
 - Parallel Processing
    Concurrent queues are ideal for tasks that can be broken down into smaller, independent units of work that can be processed concurrently.
 
 - Asynchronous Operations
    Concurrent queues are commonly used to perform asynchronous operations, such as network requests or file I/O, without blocking the main thread.
 */

// Ex: Performing Independent Tasks
let numbers = [1,2,3,4,5]
let text = "Here, we have learned both Serial and Concurrent Queues in Swift. Concurrent Queues are useful when we have multiple independent tasks that can be executed concurrently without any dependencies."
let doubles = [100, 200, 300, 400, 500]
concurrentQueue.async { print(numbers.map { $0 * 2 }) }
concurrentQueue.async { print(text.map { $0.uppercased() }.joined()) }
concurrentQueue.async { print(doubles.map { $0 / 2 }) }
Thread.sleep(forTimeInterval: 2)
print()

// Ex: Parallel Processing
let numberArr = 0..<100
let firstHalf = numberArr[0..<50]
let secondHalf = numberArr[50..<100]
concurrentQueue.async { print(firstHalf.map { $0*2 }) }
concurrentQueue.async { print(secondHalf.map { $0*2 }) }

Thread.sleep(forTimeInterval: 2)
print()

// However, we need to have a mechanism that combines these result with synchronization to prevent race conditions to shared state.
// We can't simply create var newArr = [] and append results to it in async blocks. For this, serial queue or lock mechanism can be used.
// Here, we examine serial queue
var resultingArr = [Int]()
concurrentQueue.async {
    let result = firstHalf.map { $0*2 }
    serialQueue.async {
        resultingArr.append(contentsOf: result)
        print("firstHalf Resulting array: \(resultingArr)")
    }
}
concurrentQueue.async {
    let result = secondHalf.map { $0*2 }
    serialQueue.async {
        resultingArr.append(contentsOf: result)
        print("secondHalf Resulting array: \(resultingArr)")
    }
}
Thread.sleep(forTimeInterval: 2)
print()
// Now we need a mechanism that waits for both threads to finish so that we have the latest version of the resultingArr
// Thread.sleep is not guaranteed. Using it can lead to bugs since there is no guarantee that operations will be finished in 2 seconds or so. We will examine this later
// This example also shows how you sync couple of async tasks with a serial queue to access a shared resource

/* Concurrent Queue Common Pitfalls
 - Race conditions: Shared mutable state accessed from multiple tasks without synchronization leads to data corruption.
 - Thread explosion: Spawning too many concurrent tasks can starve system resources.
 - Uncontrolled completion order: If your logic expects results in a specific sequence, you must explicitly coordinate (e.g., with dispatch groups).
 */

/* Concurrent Queue Best Practices
 - Avoid shared mutable state: Wrap access in a serial queue or use thread‑safe constructs (e.g., DispatchSemaphore, locks).
 - Throttle task submission: Use DispatchSemaphore or operation queues with max‑concurrency to limit parallelism.
 - Synchronize on completion: Use DispatchGroup or barriers when you need to wait for a set of tasks or enforce ordering.
 */


// ----------------------------------------- DispatchQueue Properties -----------------------------------------
// -> DispatchQueue Properties: label, qos, attributes, autoreleaseFrequency, target
// label: A string label to attach to the queue to uniquely identify it in debugging tools such as Instruments, sample, stackshots, and crash reports.
//      Because applications, libraries, and frameworks can all create their own dispatch queues, a reverse-DNS naming style (com.example.myqueue) is recommended.
//      This parameter is optional and can be NULL.


// qos: The quality-of-service level to associate with the queue. This value determines the priority at which the system schedules tasks for execution.
// attributes:
//    .concurrent to make the DispatchQueue concurrent
//    .initiallyInactive to make the queue inactive at initialization. You need to make activate it by activate() function to make it start
// autoreleaseFrequency:
// target:


// -> DispatchQueue functions: async, asyncAfter, asyncAndWait, schedule, sync, getSpecific
// async: Schedules a block asynchronously for execution
// async(qos): The quality-of-service class to use when executing the block. This parameter determines the priority with which the block is scheduled and executed.

// asyncAfter: Schedules a work item for execution at the specified time, and returns immediately.
concurrentQueue.asyncAfter(deadline: .now().advanced(by: .milliseconds(100))) { }
concurrentQueue.asyncAfter(deadline: .now() + 2) { } // schedules 2 seconds later

// asyncAndWait: Submits a work item for execution and returns only after it finishes executing.
concurrentQueue.asyncAndWait { }

// sync: Submits a block object for execution and returns after that block finishes executing.
concurrentQueue.sync { }





// ----------------------------------------- Dispatch Queue QoS vs Async Task QoS -----------------------------------------
/*
 Gardrops ChatGPT: https://chatgpt.com/c/686be4df-db60-8002-b853-fbc92fbedf41
 When you specify QoS at the queue level versus the block (task) level, you’re really choosing where the system should “slot” your work by default versus on a case‑by‑case basis.
 
 1. Default vs. Override
 Queue QoS (DispatchQueue(label:qos:))
 – Sets the default QoS for every task you async onto that queue (unless you override it).
 – Determines which global concurrent queue your custom queue is ultimately targeting behind the scenes.
 – Affects the entire lifetime of that queue.
 
 Block QoS (queue.async(qos:) { … })
 – Overrides the queue’s default for that single task.
 – Allows you to temporarily elevate or lower the priority for a specific unit of work, even if most of the queue runs at a different level.
 – Only influences the scheduling of that one closure.
 
 2. Inheritance & Hierarchy
 When you create a queue with a QoS, GCD will:
 - Assign your queue a target global queue of the corresponding priority.
 - All tasks (without block‑level QoS) travel to that target.
 
 When you enqueue a block with its own QoS, GCD will:
 - Use that block’s QoS to decide which global queue to dispatch it on, potentially ignoring the queue’s target.
 - The queue’s own QoS is still its “default” for any tasks without explicit overrides.
 
 */

// -> DispatchSerialQueue and DispatchConcurrentQueue


// -> A mechanism that waits for both threads to finish




// MARK: - Global Dispatch Queues: System-Provided Concurrency
/*
 - Global dispatch queues provide a convenient way to perform tasks concurrently without the need to create and manage your own queues.
 - These queues are managed by the system and are available to all applications.
 - Global dispatch queues are concurrent queues provided by the system.
 - They are available to every application and are a shared resource.
 */




// ----------------------------------------- Types of Global Dispatch Queues and Quality of Service (QoS) -----------------------------------------
/*
 Global dispatch queues are differentiated by their Quality of Service (QoS) levels.
 
 - User Interactive: DispatchQoS.QoSClass.userInteractive represents tasks that need to be performed immediately to provide a responsive user interface.
    This is the highest priority QoS level and should be used for tasks directly related to user interaction, such as animations or responding to button presses.
    Using this QoS inappropriately can negatively impact battery life.
    Example: Animating a view in response to a user tap.
 
 - User Initiated: DispatchQoS.QoSClass.userInitiated is for tasks that the user has initiated and needs to see results quickly.
    This is a high-priority QoS level, but lower than userInteractive. Use it for tasks like loading data after a button press or performing calculations needed for the UI.
    Example: Loading and displaying a user's profile information after they tap on their profile icon.

 - Default: DispatchQoS.QoSClass.default represents the default priority. If you don't specify a QoS level, tasks are assigned this priority.
    The system balances performance and energy efficiency for these tasks.
    Example: Performing general-purpose background tasks where the specific priority is not critical.
 
 - Utility: DispatchQoS.QoSClass.utility is for tasks that require minimal user interaction and can take longer to complete.
    This QoS level is designed for tasks like downloading data, importing large files, or performing I/O operations.
    The system prioritizes energy efficiency over speed for these tasks.
    Example: Downloading a large file in the background.
 
 - Background: DispatchQoS.QoSClass.background is the lowest priority QoS level and is used for tasks that don't require user interaction
    and can be performed in the background without impacting the user experience. Examples include indexing data, performing backups, or syncing data with a server.
    The system highly prioritizes energy efficiency for these tasks.
    Example: Performing a nightly backup of user data.
 
 - Unspecified: DispatchQoS.QoSClass.unspecified indicates that the QoS class is not specified. The system treats these tasks with a lower priority than the default QoS class.
 */




// ----------------------------------------- Obtaining a Global Dispatch Queue -----------------------------------------
let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
let utilityQueue = DispatchQueue.global(qos: .utility)
let backgroundQueue = DispatchQueue.global(qos: .background)



// ----------------------------------------- Executing Tasks on Global Dispatch Queues -----------------------------------------
let globalDispatchQueue = DispatchQueue.global()

globalDispatchQueue.async {
    // Perform a long-running task in the background
    print("Performing task on background queue")
    Thread.sleep(forTimeInterval: 2) // Simulate a long-running task
    print("Task completed on background queue")
}

Thread.sleep(forTimeInterval: 2)
print()

/* -> Does DispatchQueue.global() creates a new or pulls a DispatchQueue from a poll or something since it is a function?
 Gardrops ChatGpt: https://chatgpt.com/c/686be4df-db60-8002-b853-fbc92fbedf41#:~:text=What%20is%20the%20mechanism%20behind
 When you call DispatchQueue.global(), you’re not creating a brand‑new queue each time; you’re getting a reference
 (a lightweight Swift “wrapper”) to one of the system’s shared, long‑lived global concurrent queues.
 Under the hood:

 1. One Queue per QoS
 - The system maintains exactly one global queue for each Quality‑of‑Service class (plus a “default” queue).

 2. Wrapper vs. Underlying Object
 - DispatchQueue.global() is just a Swift API that calls the C function dispatch_get_global_queue(qos, flags).
 - That C function always returns the same dispatch_queue_t pointer for a given QoS.
 - Swift then wraps that pointer in a new lightweight DispatchQueue struct (which is just a reference to the underlying queue).
 
 3. Thread Pool Management
 - GCD maintains a dynamic pool of worker threads. When you submit a block to a global queue, GCD picks an available thread
    (or spins up a new one, up to its internal limits) and executes your work.
    None of that changes whether you “ask” for the queue once or a hundred times.
 
 */

// MARK: - Main Queue
/*
 - Definition: A special serial queue associated with the main thread of your application.
 - All UI updates and user interactions must occur on this queue.
 - If you perform heavy tasks on the main queue, you will block UI updates and user interactions, making your app unresponsive.
 */
DispatchQueue.main.async {
    // Update UI safely here
    print("UI updated on main queue")
}

Thread.sleep(forTimeInterval: 2)
print()


// MARK: - Creating and Managing Custom Dispatch Queues
/*
 While global dispatch queues provide convenient access to system-managed concurrency, custom queues offer greater control over execution context, priority, and queue behavior.
 */

// -> Suspending and Resuming Queues
// Suspend the queue. Prevents the queue from executing new tasks. Tasks already in progress will continue to run.
serialQueue.suspend()

// Later, resume the queue
serialQueue.resume()

/* Impact of Suspending a Queue
     - Tasks submitted to a suspended queue are held in the queue but are not executed until the queue is resumed.
     - Suspending a queue does not interrupt tasks that are already running.
     - You can suspend and resume a queue multiple times.
 */

// MARK: - Dispatch Queue Hierarchies
/* 1. Concepts of Queue Hierarchy
 - Dispatch queues can be organized into hierarchies, where one queue acts as the target queue for another.
 - This allows you to influence the execution characteristics of a queue by associating it with a target queue.
 - This gives you a tree‑like hierarchy of queues.
    * Parent (target) queue controls certain characteristics—QoS, max concurrency, suspension state—that its child queues inherit by default.
    * Child queues enqueue work into their parent under the hood, but still retain their own identity (labels, attributes).
 
 - Visually
             ┌───────────────────┐
             │   Parent Queue    │
             │ (e.g. concurrent, │
             │    qos: .utility) │
             └───────────────────┘
                ▲             ▲
 ┌──────────────────┐ ┌──────────────────┐
 │ Child Queue A    │ │ Child Queue B    │
 │ (serial, labelA) │ │ (serial, labelB) │
 └──────────────────┘ └──────────────────┘
    * Child A and Child B both feed their tasks into Parent Queue, so their effective concurrency and QoS mirror the parent’s settings.
 
 */

/* 2. The target Property
 Every DispatchQueue provides a setTarget(queue:) method (or via initializer) to specify which queue its work should actually be merged into.
 */
// -> Set target at initialization
// Create a “throttled” concurrent parent:
let parent = DispatchQueue(label: "com.app.parent", qos: .utility, attributes: .concurrent)

// Create two serial children targeting that same parent:
let childA = DispatchQueue(label: "com.app.childA", target: parent)
let childB = DispatchQueue(label: "com.app.childB", target: parent)

// -> Set target after creation
let childC = DispatchQueue(label: "com.app.childC")
childC.setTarget(queue: parent)

/*
 - Once targeted, any work you dispatch to childA.async { … } actually enqueues on parent behind the scenes (but still serialized within A).
 - "serialized within A" means;
    * Order of submission matters: Even though both childA and its parent queue share the same pool of threads, any tasks you enqueue on childA are
        guaranteed to start in the exact order you submitted them to childA.
    * Child‑level FIFO: Behind the scenes, childA keeps its own little FIFO buffer.
    * Parallelism comes only from the parent: The parent queue might be able to run multiple tasks at once, but it will only pull the next
        childA block once the previous one has been handed off. That hand‑off guarantees “one‑at‑a‑time” ordering for everything coming from childA.
    So;
        * childA defines the ordering (serial).
        * parent defines the concurrency level (how many threads may actually be running those ordered tasks concurrently with other work).
 
 This lets you have, for example, multiple independent serial sub‑queues (childA, childB, etc.), all feeding into one concurrent parent.
 Each child still runs its own tasks in sequence, but different children can run in parallel.
 */

/* Key Benefits, Pitfalls & Howw to Avoid Them, Wen to Use Queue Hierarchies
 Gardrops Chatgpt: https://chatgpt.com/c/686be4df-db60-8002-b853-fbc92fbedf41#:~:text=3.-,Key%20Benefits,-3.1%20Coordinated%20QoS
 */
 
/* Question 1.1
 I wonder what happens in the following case;
 - There is a parent queue which is concurrent called parentQueue
 - There are two child queues which are serial called childQueue1 and childQueue2
 - Both child queues target the parentQueue
 - I pass 5 tasks to childQueue1 and 10 tasks to childQueue2. What happens? Are tasks run in sync or async? Extract all possible cases and explain them in detail
 
 Answer
 Gardrops Chatgpt: https://chatgpt.com/c/686be4df-db60-8002-b853-fbc92fbedf41#:~:text=When%20you%20have%20a%20concurrent
 
 Question 1.2
 - What happens if one of the children is a concurrent queue? Rethink all the case and do the same for one child is serial and the other is concurrent
 */

/* Question 2
 When I create a new DispatchQueue, does it inherently targets the corresponding global DispatchQueue or it is completely different from global DispatchQueue?
 
 */


// Create a target queue (e.g., a global queue)
let targetQueue = DispatchQueue.global(qos: .utility)

// Create a custom queue with the target queue
let customQueueWithTarget = DispatchQueue(label: "com.example.customWithTarget", target: targetQueue)
// target: Specifies the target queue for the new queue.
// Tasks submitted to customQueueWithTarget will ultimately be executed on targetQueue.












// async(group) and async(flags)
// asyncAndWait in detail (look for its docs)
// sync in detail (look for its docs)
// asyncAndWait vs sync
// asyncUnsafe, asyncAfterUnsafe,
// responds in detail
// getSpecific in detail
// DispatchQueue docs: Avoiding Excessive Thread Creation
// autoreleaseFrequency


Thread.sleep(forTimeInterval: 1)
