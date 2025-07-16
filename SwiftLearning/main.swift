//
//  main.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 18.04.2023.
//

import Foundation
import Combine

/*
 1. Intro: The Main Idea + Simple Combine Flow
 2. Publishers
 3. Subscribers
 4. Subjects
 5. Operators
 6. Schedulers
 7. Memory Management & Cancellation
 8. Combine in Practice: Common Use Cases
 9. Testing Combine Code
 10. Advanced Topics
 11. Custom Publishers & Subscribers
 12. Best Practices & Patterns
 13. Common Pitfalls
 14. Performance
 15. Debugging
 16. Associated Tools
 17. Ecosystem & Further Resources
 18. Future Directions
 */

// MARK: - Publishers
/*
 Publishers are types that expose values that can change over time.
 They emit values to one or more Subscribers.
 Publishers declare the type of values they emit and the type of error they can potentially produce.
 */
// Just: Emits a single, predefined value and then completes.
let justPublisher = Just("Hello, Combine!")

/* Use Cases for Just Publisher
 
 */




// Future: Represents a single result that will be available at some point in the future.
// It's useful for wrapping asynchronous operations.
let futurePublisher = Future<String, Error> { promise in
    DispatchQueue.global().async {
        // Simulate an asynchronous operation
        Thread.sleep(forTimeInterval: 2)
        promise(.success("Result from the future!"))
        //promise(.failure(SomeError.example)) // Example of failure
    }
}

/* Use Cases for Future Publisher
 
 */


// PassthroughSubject: A subject that broadcasts values to multiple subscribers.
// It doesn't have an initial value or store the most recent value.
let passthroughSubject = PassthroughSubject<String, Never>() // The String type means it publishes String values over time.
                                                             // The Never type indicates that this publisher
                                                             // never emits an error.

passthroughSubject.send("First value")
passthroughSubject.send("Second value")
passthroughSubject.send("Third value")
passthroughSubject.send(completion: .finished) // Signal completion

/* Use Cases for PassthroughSubject
 
 */

// CurrentValueSubject: A subject that holds the most recent value and publishes it to new subscribers.

/* Use Cases for CurrentValueSubject
 
 */



// MARK: - Subscribers
/*
 Subscribers are types that receive values from Publishers.
 They subscribe to a Publisher and react to the values emitted by the Publisher.
 */

/* Subscriber Lifecycle
 A Subscriber goes through the following stages:
    - Subscription: The Subscriber subscribes to a Publisher.
    - Request: The Subscriber requests a certain number of values from the Publisher.
    - Value Reception: The Subscriber receives values from the Publisher.
    - Completion: The Publisher completes, either successfully or with an error.
 */

/* Types of Subscribers
 Combine provides built-in Subscribers like sink and assign.
     - sink: Provides closures to handle received values and completion events.
     - assign: Assigns received values to a property of an object.
 */

// -> Subscribing to Just

// -> Subscribing to Future

// -> Subscribing to PassthroughSubject

// -> Subscribing to CurrentValueSubject

// -> receiveValue and receiveCompletion

/* Core Concepts of Subscribers
 - Subscription Request: Subscribers request a specific number of values from the Publisher.
    This is done through a Subscription object.
 
 - Value Reception: Subscribers receive values emitted by the Publisher.
 - Completion Handling: Subscribers handle the successful completion of the Publisher.
 - Error Handling: Subscribers handle any errors emitted by the Publisher.
 - Backpressure: Subscribers can control the rate at which they receive values, preventing them from being overwhelmed by a fast-emitting Publisher.
 
 */

/* Managing Subscriptions
 Subscriptions in Combine are represented by AnyCancellable objects.
 It's crucial to store these objects to keep the subscription alive.
 When the AnyCancellable is deallocated, the subscription is automatically cancelled.
 A common practice is to use a Set<AnyCancellable> to manage multiple subscriptions.
 */


// MARK: - Operators
/*
 Operators are methods that you can call on a Publisher to transform the values it emits.
 They allow you to modify, filter, combine, or otherwise manipulate the data stream.
 */

/* Types of Operators
 Combine provides a rich set of operators, including:
    - map: Transforms each value emitted by the Publisher.
    - filter: Emits only values that satisfy a certain condition.
    - removeDuplicates: Emits only values that are different from the previous value.
    - replaceNil: Replaces nil values with a default value.
    - combineLatest: Combines the latest values from multiple Publishers.
    - zip: Combines values from multiple Publishers in a specific order.
    - catch: Handles errors emitted by the Publisher.
    - flatMap: Transforms each value into a new Publisher and then flattens the stream
        of Publishers into a single Publisher. This is useful for working with asynchronous
        operations that return Publishers.
    - debounce:
 */

// -> map Example

// -> filter Example

// -> removeDuplicates Example

// -> replaceNil Example

// -> combineLatest Example

// -> zip Example

// -> catch Example

// -> flatMap Example

// -> Other use cases

// -> Operator Chaining:

/* Core Concepts of Operators
 - Transformation: Operators can transform the values emitted by a Publisher.
    For example, you can use the map operator to convert a string to an integer.
 
 - Filtering: Operators can filter the values emitted by a Publisher, only allowing
    certain values to pass through. For example, you can use the filter operator to
    only allow even numbers to pass through.
 
 - Combining: Operators can combine multiple Publishers into a single Publisher.
    For example, you can use the zip operator to combine the latest values from two Publishers.
 
 - Error Handling: Operators can handle errors emitted by a Publisher. For example,
    you can use the catch operator to recover from an error and continue the data stream.
 
 */


// MARK: - Subjects
/*
 Subjects are a special type in Combine that act as both a Publisher and a Subscriber.
 This means they can both receive values and emit them to other Subscribers.
 
 PassthroughSubject
 As seen earlier, PassthroughSubject is a type of Subject that simply passes along values
 it receives to its subscribers. It doesn't store any value itself.
 The passthroughSubject only emits values that are sent to it after the subscription is established.
 
 CurrentValueSubject
 CurrentValueSubject holds a current value and emits it to every new subscriber.
 When it receives a new value, it emits that value to all its subscribers.
 Subsequent values sent to the subject are also emitted even subscription is established after.
 */



// MARK: - Schedulers
/*
 Schedulers define the execution context for Publishers and Subscribers.
 They determine which thread or queue the code will run on.
 Combine provides several built-in Schedulers, such as:
     - DispatchQueue: Executes code on a dispatch queue.
     - OperationQueue: Executes code on an operation queue.
     - RunLoop: Executes code on a run loop.
 */
let numbers = [1, 2, 3, 4, 5].publisher

// Performing operations on a background queue
let subscription = numbers
    .map { number -> Int in
        print("Mapping \(number) on thread: \(Thread.current)")
        return number * 2
    }
    .subscribe(on: DispatchQueue.global()) // Subscribe on background thread
    .receive(on: DispatchQueue.main) // Receive results on main thread
    .sink { value in
        print("Received \(value) on thread: \(Thread.current)")
    }

/*
 In this example, the subscribe(on:) operator specifies that the subscription and initial
 processing should occur on a background queue. The receive(on:) operator specifies that
 the results should be received on the main queue, which is important for updating UI elements.
 
 In other words, sink Operators are run on the Scheduler defined by 'subscribe',
 sink or assign are run on Scheduler defined by 'receive'
 */




// MARK: - Publisher Protocol

// MARK: - Subscriber Protocol

// MARK: - Custom Publisher

// OperationQueue
// RunLoop
// Lifecycle-aware subscription
