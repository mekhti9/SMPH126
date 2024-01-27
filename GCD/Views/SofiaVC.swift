//
//  SofiaVC.swift
//  GCD
//
//  Created by mehdimagerramov on 26.01.2024.
//

import UIKit

class SofiaVC: UIViewController {
    
    let image = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "sofia"
        downloadImage()
        configureImage()
    }
    
    func configureImage() {
        view.addSubview(image)
        image.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        image.center = view.center
    }
    
    func downloadImage() {
        guard let imageURL = URL(string: "https://i.pinimg.com/564x/a5/3c/9a/a53c9a706f7234038c81cad7ba287512.jpg") else { return }
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
        }
    }

}
