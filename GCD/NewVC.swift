//
//  NewVC.swift
//  GCD
//
//  Created by mehdimagerramov on 25.01.2024.
//

import UIKit

class NewVC: UIViewController {
    
    let imageURL = URL(string: "https://i.pinimg.com/564x/00/d9/08/00d9081a014a64d643e73344fa83ab4d.jpg")!
    let image = UIImageView()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureViews()
        fetchImage3()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureViews() {
        view.addSubview(image)
        view.addSubview(button)
        
        image.clipsToBounds = true
        image.layer.cornerRadius = 16
        image.translatesAutoresizingMaskIntoConstraints = false
        
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.setTitle("semaphore", for: .normal)
        button.addTarget(self, action: #selector(imageTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            image.heightAnchor.constraint(equalToConstant: 550),
            
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16)
        ])
    }
    
    @objc func imageTap() {
        let semaphoreVC = SemaphoreVC()
        navigationController?.pushViewController(semaphoreVC, animated: true)
    }
    
    //classic
    func fetchImage() {
        let queue = DispatchQueue.global(qos: .utility)
        
        queue.async {
            if let data = try? Data(contentsOf: self.imageURL) {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
        }
    }
    
    //dispatch work item
    func fetchImage2() {
        var data: Data?
        let queue = DispatchQueue.global(qos: .utility)
        
        let workItem = DispatchWorkItem(qos: .userInteractive) {
            data = try? Data(contentsOf: self.imageURL)
            print(Thread.current)
        }
        
        queue.async(execute: workItem)
        workItem.notify(queue: DispatchQueue.main) {
            if let imageData = data {
                self.image.image = UIImage(data: imageData)
            }
        }
    }
    
    //URLSession
    func fetchImage3() {
        let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            print(Thread.current)
            if let imageData = data {
                DispatchQueue.main.async {
                    print(Thread.current)
                    self.image.image = UIImage(data: imageData)
                }
            }
        }
        task.resume()
    }
}

//class DispatchWorkItem12 {
//    
//    private let queue = DispatchQueue(label: "DispatchWorkItem1")
//    
//    func create() {
//        queue.async {
//            sleep(1)
//            print(Thread.current)
//            print("task 1")
//        }
//        
//        queue.async {
//            sleep(1)
//            print(Thread.current)
//            print("task 2")
//        }
//        
//        let workItem = DispatchWorkItem {
//            print(Thread.current)
//            print("start work item task")
//        }
//        
//        queue.async(execute: workItem)
//        
//        workItem.cancel()
//    }
//}
