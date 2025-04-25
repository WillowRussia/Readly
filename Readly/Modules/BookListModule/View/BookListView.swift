//
//  DetailsView.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import UIKit
import SwiftUI

protocol BookListViewProtocol: BaseViewProtocol {

}

class BookListView: UIViewController, BookListViewProtocol {
    
    typealias PresenterType = BookListPresenterProtocol
    var presenter: PresenterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = BookListViewContent(books: presenter?.bookList ?? [], bookTitle: presenter?.bookTitle ?? "Неизвестное имя") { [weak self] book in
            guard let self = self else { return }
            if let book = book {
                let viewController = Builder.createAddDetailsView(book: book)
                navigationController?.pushViewController(viewController, animated: true)
            } else {
                navigationController?.popViewController(animated: true)
            }
            
        }
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
    
}
