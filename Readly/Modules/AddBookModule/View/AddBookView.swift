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

class AddBookView: UIViewController, AddBookViewProtocol {
    
    typealias PresenterType = AddBookPresenterProtocol
    var presenter: PresenterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = AddBookViewContent(){ [weak self] bookName in
            guard let self = self else { return }
            if let title = bookName {
                self.presenter?.searchBooks(by: title)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
    
    func goToBookListView(bookList: [JsonBookModelItem], bookTitle: String) {
        let viewControllerc = Builder.createBookListView(bookList: bookList, bookTitle: bookTitle)
        navigationController?.pushViewController(viewControllerc, animated: true)
    }
    
    func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
}
