//
//  AddDetailsRouter.swift
//  Readly
//
//  Created by Илья Востров on 02.10.2025.
//


import UIKit

protocol AddDetailsRouter {
    func close()
    func returnToRoot()
}

final class AddDetailsRouterImplementation: AddDetailsRouter {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func close() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func returnToRoot() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}