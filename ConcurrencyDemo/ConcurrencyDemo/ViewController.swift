//
//  ViewController.swift
//  ConcurrencyDemo
//
//  Created by james on 28/04/2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        Task {
            //            await doSomething()
            await doSomethingInGroup()
        }
    }
    
    func doSomething() async {
        print("Start \(Date())")
        //        async let result = takesTooLong(delay: 3)
        //        print("After async-let \(Date())")
        // Additional code to run concurrently with async function goes here
        //        print ("result = \(await result)")
        do {
            _ = try await takesTooLong(delay: 25)
            
        } catch DurationError.tooShort {
            print("Error: Duration too short")
        } catch DurationError.tooLong {
            print("Error: Duration too long")
        } catch {
        }
        print("End \(Date())")
    }
    
    func takesTooLong(delay: Int) async throws -> Date {
        if delay < 5 {
            throw DurationError.tooShort
        } else if delay > 20 {
            throw DurationError.tooLong
        }
        
        await taskSleep(delay)
        print("Async task completed at \(Date())")
        return Date()
    }
    
    func taskSleep(_ delay: Int) async {
        do {
            try await Task.sleep(until: .now + .seconds(delay), clock: .continuous)
        } catch {
            
        }
    }
    
    func doSomethingInGroup() async {
        var timeStamps: [Int: Date] = [:]
        
        await withTaskGroup(of: (Int, Date).self) { taskGroup in
            for i in 0..<5 {
                taskGroup.addTask {
                    let result = try? await self.takesTooLong(delay: 5)
                    print("Task \(i): \(result!)")
                    return (i, result!)
                }
            }
            
            for await (task, date) in taskGroup {
                timeStamps[task] = date
            }
        }
        
        for (task, date) in timeStamps {
            print("Task = \(task), Date = \(date)")
        }
    }
}

enum DurationError: Error {
    case tooLong
    case tooShort
}
