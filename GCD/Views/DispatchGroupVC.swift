//
//  DispatchGroupVC.swift
//  GCD
//
//  Created by mehdimagerramov on 27.01.2024.
//

import UIKit

class DispatchGroupVC: UIViewController {
    
    public var arrayImage = [UIImageView]()
    public var images = [UIImage]()
    let button = UIButton()
    
    public let imageURLs = ["https://i.pinimg.com/originals/d8/6a/d6/d86ad6325cb34e4d52d38c9323844142.jpg", "https://i.pinimg.com/236x/f5/ce/ac/f5ceac14ec8edfc645108a7599f5f03f.jpg", "https://i.pinimg.com/236x/4b/47/58/4b475836eb0697b2bb24325c578f06a4.jpg", "https://i.pinimg.com/236x/41/1b/84/411b845ecac7a53a85b2b6167a375536.jpg", "https://i.pinimg.com/564x/35/ca/a0/35caa0d3271f7982a91ae0d0ffd35574.jpg"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        imageConfigure()
        asyncGroup()
        configureButton()
    }
    
    func configureButton() {
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        view.addSubview(button)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.backgroundColor = .brown
        button.center = view.center
        button.layer.cornerRadius = 16
        button.setTitle("Barrier", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)

    }
    
    @objc func actionButton() {
        let barrier = BarrierVC()
        self.navigationController?.pushViewController(barrier, animated: true)
    }
    
    func imageConfigure() {
        arrayImage.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        arrayImage.append(UIImageView(frame: CGRect(x: 0, y: 200, width: 100, height: 100)))
        arrayImage.append(UIImageView(frame: CGRect(x: 200, y: 0, width: 100, height: 100)))
        arrayImage.append(UIImageView(frame: CGRect(x: 200, y: 100, width: 100, height: 100)))
        
        arrayImage.append(UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100)))
        arrayImage.append(UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100)))
        arrayImage.append(UIImageView(frame: CGRect(x: 0, y: 400, width: 100, height: 100)))
        arrayImage.append(UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100)))
        
        for i in 0..<arrayImage.count {
            view.addSubview(arrayImage[i])
            arrayImage[i].contentMode = .scaleAspectFit
            arrayImage[i].layer.cornerRadius = 12
        }
    }
    
    func asyncLoadImages(imageURL: URL, runQueue: DispatchQueue, completionQueue: DispatchQueue, completion: @escaping (UIImage?, Error?) -> ()) {
        
        runQueue.async {
            do {
                let data = try Data(contentsOf: imageURL)
                completionQueue.async { completion(UIImage(data: data), nil) }
            } catch let error {
                completionQueue.async { completion(nil, error) }
            }
        }
    }
    
    func asyncGroup() {
        let testGroup = DispatchGroup()
        
        for i in 0..<imageURLs.count {
            testGroup.enter()
            asyncLoadImages(imageURL: URL(string: imageURLs[i])!, runQueue: .global(), completionQueue: .main) { result, error in
                guard let image1 = result else { return }
                self.images.append(image1)
                testGroup.leave()
            }
        }
        testGroup.notify(queue: .main) {
            for i in 0..<self.imageURLs.count {
                self.arrayImage[i].image = self.images[i]
            }
        }
    }
    
    func asyncURLSession() {
        
    }
}
