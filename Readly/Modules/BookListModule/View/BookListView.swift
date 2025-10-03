//
//  DetailsView.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import UIKit
import SwiftUI

protocol BookListViewProtocol: AnyObject {
    func display(books: [JsonBookModelItem], title: String)
}

final class BookListView: UIViewController, BookListViewProtocol {
    
    var presenter: BookListPresenterProtocol?
    
    
    func display(books: [JsonBookModelItem], title: String) {
        let contentView = BookListViewContent(
            books: books,
            bookTitle: title,
            onAction: { [weak self] action in
                switch action {
                case .selectBook(let book):
                    self?.presenter?.didSelectBook(book)
                case .goBack:
                    self?.presenter?.didTapBack()
                }
            }
        )
        
        let hostingController = UIHostingController(rootView: contentView)
        
        addChild(hostingController)
        hostingController.view.frame = self.view.bounds
        self.view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}
