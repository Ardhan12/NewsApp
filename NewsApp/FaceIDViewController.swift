//
//  FaceIDViewController.swift
//  NewsApp
//
//  Created by Arief Ramadhan on 14/02/23.
//

import UIKit
import LocalAuthentication

class FaceIDViewController: UIViewController {

    let NewsHeader: UILabel = {
        let label = UILabel()
        label.text = "Welcome To News App"
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
//        button.frame.size = CGSize(width: 250, height: 100)
//        button.layer.backgroundColor = .systemRed
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.setTitle("News App", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func didTapButton(sender: Any) {
        let context = LAContext()
        
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            let reason = "Please authorize with face id"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        //failed
                        let alert = UIAlertController(title: "Failed to Authenticated", message: "Please try again!", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                        
                        self?.present(alert, animated: true)
                        return
                    }
                    //show other screen
                    let vc = ViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        else {
            //catch
            let alert = UIAlertController(title: "Unavailable", message: "You can't use this feature", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            
            present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(NewsHeader)
        view.addSubview(button)
        view.backgroundColor = .white
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        NewsHeader.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10).isActive = true
        NewsHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        // Do any additional setup after loading the view.
    }

}
