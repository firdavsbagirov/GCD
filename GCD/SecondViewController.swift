//
//  SecondViewController.swift
//  GCD
//
//  Created by Firdavs Bagirov on 10/30/20.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        delay(3) {
            self.loginAlert()
        }
        
    }
    
    fileprivate func delay (_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }

    fileprivate func loginAlert() {
        let ac = UIAlertController(title: "Registered?", message: "Enter your login and password", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { (userNameTF) in
            userNameTF.placeholder = "Enter login"

        }
        
        ac.addTextField { (userPasswordTF) in
            userPasswordTF.placeholder = "Enter password"
            userPasswordTF.isSecureTextEntry = true
        }
        
        present(ac, animated: true, completion: nil)
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Northern_masked_weaver_%28Ploceus_taeniopterus%29_female.jpg/1920px-Northern_masked_weaver_%28Ploceus_taeniopterus%29_female.jpg")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else  { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)

            }
        }
    }
}
    


