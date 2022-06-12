//
//  ErrorAlert.swift
//  vk-ilia
//
//  Created by Ilia Zakharov on 16.05.2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func errorAlert(title: String, message: String) {
        
        //preferredStyle появление посреди экрана
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let error = UIAlertAction(title: "Error", style: .default)
        alertController.addAction(error)
        
        present(alertController, animated: true)
        
    }
    
}
