//
//  UIViewController.ext.swift
//  Readly
//
//  Created by Илья Востров on 02.10.2025.
//

import UIKit

extension UIViewController {

    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {

        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                completion?()
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
