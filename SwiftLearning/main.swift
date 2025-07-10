//
//  main.swift
//  SwiftLearning
//
//  Created by Ömer Faruk Okumuş on 18.04.2023.
//

import Foundation
import Combine

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


// PassthroughSubject: A subject that broadcasts values to multiple subscribers.
// It doesn't have an initial value or store the most recent value.
let passthroughSubject = PassthroughSubject<String, Never>() // The String type means it publishes String values over time.
                                                             // The Never type indicates that this publisher
                                                             // never emits an error.

passthroughSubject.send("First value")
passthroughSubject.send("Second value")
passthroughSubject.send("Third value")
passthroughSubject.send(completion: .finished) // Signal completion

// CurrentValueSubject: A subject that holds the most recent value and publishes it to new subscribers.



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
     - combineLatest: Combines the latest values from multiple Publishers.
     - zip: Combines values from multiple Publishers in a specific order.
 
 */



// MARK: - Subjects
/*
 Subjects are a special type in Combine that act as both a Publisher and a Subscriber.
 This means they can both receive values and emit them to other Subscribers.
 Subjects are useful for bridging imperative code with Combine's declarative style.
 
 PassthroughSubject
 As seen earlier, PassthroughSubject is a type of Subject that simply passes along values
 it receives to its subscribers. It doesn't store any value itself.
 
 CurrentValueSubject
 CurrentValueSubject holds a current value and emits it to every new subscriber.
 When it receives a new value, it emits that value to all its subscribers.
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




// MARK: - Publisher Protocol

// MARK: - Subscriber Protocol

// MARK: - Custom Publisher
