//
//  RegistView.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//

import UIKit
import SwiftUI

protocol RegistViewProtocol: BaseViewProtocol{
    func showAlert(title: String, message: String)
}

class RegistView: UIViewController, RegistViewProtocol {
    typealias PresenterType = RegistPresenterProtocol
    var presenter: PresenterType?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = RegistViewContent{ [weak self] in
            guard let self = self else { return }
            self.presenter?.checkName(name: $0)
        }
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.bounds
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
    
    func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }


}
