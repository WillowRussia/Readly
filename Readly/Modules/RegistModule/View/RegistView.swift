//
//  RegistView.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//

import UIKit
import SwiftUI

protocol RegistViewProtocol: AnyObject {
    func showAlert(title: String, message: String)
}

final class RegistView: UIViewController, RegistViewProtocol {
    
    var presenter: RegistPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentView = RegistViewContent{ [weak self] name in
            guard let self = self else { return }
            self.presenter?.registerButtonPressed(name: name)
        }
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.bounds
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
    
    func showAlert(title: String, message: String) {
        super.showAlert(title: title, message: message)
    }
}
