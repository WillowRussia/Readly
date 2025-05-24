//
//  DetailsView.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import UIKit
import SwiftUI

protocol AddBookViewProtocol: BaseViewProtocol {
    func goToBookListView(bookList: [JsonBookModelItem], bookTitle: String)
    func showAlert(title: String, message: String)
}

class LoadingState: ObservableObject {
    @Published var isLoading: Bool = false
}

class AddBookView: UIViewController, AddBookViewProtocol {
    
    typealias PresenterType = AddBookPresenterProtocol
    var presenter: PresenterType?
    
    private let loadingState = LoadingState()

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentView = AddBookViewContent(loadingState: loadingState) { [weak self] bookName in
            guard let self = self else { return }
            if let title = bookName {
                self.loadingState.isLoading = true
                self.presenter?.searchBooks(by: title)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }

        let hostingController = UIHostingController(rootView: contentView)
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }

    func goToBookListView(bookList: [JsonBookModelItem], bookTitle: String) {
        loadingState.isLoading = false
        let viewController = Builder.createBookListView(bookList: bookList, bookTitle: bookTitle)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showAlert(title: String, message: String) {
        loadingState.isLoading = false
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
