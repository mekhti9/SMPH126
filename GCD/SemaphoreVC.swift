//
//  SemaphoreVC.swift
//  GCD
//
//  Created by mehdimagerramov on 26.01.2024.
//

import UIKit

class SemaphoreVC: UIViewController {
    
    let queue = DispatchQueue(label: "new queue", attributes: .concurrent)
    let semaphore = DispatchSemaphore(value: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "semaphores"
        view.backgroundColor = .systemBlue
        dispatch()
    }
    
    func dispatch() {
        queue.async {
            self.semaphore.wait() //-1 to value
            sleep(3)
            print("method 1")
            self.semaphore.signal() //+1 to value
        }
        
        queue.async {
            self.semaphore.wait() //-1 to value
            sleep(3)
            print("method 2")
            self.semaphore.signal() //+1 to value
        }
        
        queue.async {
            self.semaphore.wait() //-1 to value
            sleep(3)
            print("method 3")
            self.semaphore.signal() //+1 to value
        }
    }
}
