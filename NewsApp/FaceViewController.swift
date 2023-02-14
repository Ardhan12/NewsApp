//
//  FaceViewController.swift
//  NewsApp
//
//  Created by Arief Ramadhan on 14/02/23.
//

import UIKit
import LocalAuthentication

class FaceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        FaceID()
        
    }
    
    private func FaceID() {
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

}
