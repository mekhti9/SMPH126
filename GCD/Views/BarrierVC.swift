//
//  BarrierVC.swift
//  GCD
//
//  Created by mehdimagerramov on 27.01.2024.
//

import UIKit

class BarrierVC: UIViewController {
    
    
    ///WRONG CODE
//    var array = [Int]()
//
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        //dispatcch()
        var safeaarr = SafeArray<Int>()
        DispatchQueue.concurrentPerform(iterations: 12) { index in
            safeaarr.append(value: index)
        }
        print("arraysafe:", safeaarr.valueArray())
        print("arraysafe:", safeaarr.valueArray().count)
    }
//    
//    func dispatcch() {
//        DispatchQueue.concurrentPerform(iterations: 10) { index in
//            array.append(index)
//        }
//        print(array)
//        print(array.count)
//    }
}

//CORRECT CODE
class SafeArray<T> {
    
    private var array = [T]()
    private let queue = DispatchQueue(label: "M3COMP", attributes: .concurrent)
    
    public func append(value: T) {
        queue.async(flags: .barrier) {
            self.array.append(value)
        }
    }
    
    public func valueArray() -> [T] {
        var result = [T]()
        queue.sync {
            result = self.array
        }
        return result
    }
}


