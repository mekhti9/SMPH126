//
//  SemaphoreVC.swift
//  GCD
//
//  Created by mehdimagerramov on 26.01.2024.
//

import UIKit

class SemaphoreVC: UIViewController {
    
    let queue = Dispatch.DispatchQueue(label: "new queue", attributes: .concurrent)
    let semaphore = DispatchSemaphore(value: 1)
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "semaphores"
        view.backgroundColor = .systemBackground
        dispatch()
        SemaphoreTest().startAllThreads()
        configureButton()
    }
    
    func configureButton() {
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        view.addSubview(button)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.backgroundColor = .brown
        button.center = view.center
        button.layer.cornerRadius = 16
        button.setTitle("dispatch group", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)

    }
    
    @objc func actionButton() {
        let dispGroup = DispatchGroupVC()
        self.navigationController?.pushViewController(dispGroup, animated: true)
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
//    let sema = DispatchSemaphore(value: 1)
//    DispatchQueue.concurrentPerform(iterations: 10) { id in
//        sema.wait(timeout: DispatchTime.distantFuture)
//        sleep(1)
//        print("Block", String(id))
//        sema.signal()
}



class SemaphoreTest {
    private let semaphore = DispatchSemaphore(value: 2)
    private var array = [Int]()
    
    private func methodWork(id: Int) {
        semaphore.wait() // -1
        array.append(id)
        print("test array", array.count)
        
        Thread.sleep(forTimeInterval: 1)
        semaphore.signal() // +1
    }
    
    public func startAllThreads() {
        DispatchQueue.global().async {
            self.methodWork(id: 111)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(id: 374)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(id: 434)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(id: 584)
            print(Thread.current)
        }
    }
}
