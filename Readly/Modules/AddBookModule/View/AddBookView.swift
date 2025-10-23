//
//  DetailsView.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import UIKit
import SwiftUI

protocol AddBookViewProtocol: AnyObject {
    func showLoading(_ isLoading: Bool)
    func showAlert(title: String, message: String)
}

final class AddBookView: UIViewController, AddBookViewProtocol {
    
    var presenter: AddBookPresenterProtocol?
    private let loadingState = LoadingState()

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentView = AddBookViewContent(loadingState: loadingState) { [weak self] bookName in
            guard let self = self else { return }
            if let title = bookName, !title.isEmpty {
                self.presenter?.searchBooks(by: title)
            } else {
                self.presenter?.didTapCloseButton()
            }
        }

        let hostingController = UIHostingController(rootView: contentView)
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }

    func showLoading(_ isLoading: Bool) {
        loadingState.isLoading = isLoading
    }

    func showAlert(title: String, message: String) {
        super.showAlert(title: title, message: message)
    }
}
