//
//  ViewController.swift
//  GCD
//
//  Created by mehdimagerramov on 25.01.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        myInactiveQueue()
        configureVC()
        configureButton()
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureButton() {
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        view.addSubview(button)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.backgroundColor = .systemPink
        button.center = view.center
        button.layer.cornerRadius = 16
        button.setTitle("sofia", for: .normal)        
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)

    }
    
    @objc func actionButton() {
        let sofiaVC = SofiaVC()
        self.navigationController?.pushViewController(sofiaVC, animated: true)
    }
    
    func myInactiveQueue() {
        let inactiveQueue = DispatchQueue(label: "m3 competition", attributes: [.concurrent, .initiallyInactive])
        
        inactiveQueue.async {
            print("done")
        }
        print("didnt start yet")
        inactiveQueue.activate()
        print("activate")
        inactiveQueue.suspend()
        print("paused")
        inactiveQueue.resume()
    }
}


