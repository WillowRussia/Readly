//
//  DetailsView.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import UIKit
import SwiftUI

protocol DetailsViewProtocol: BaseViewProtocol {
    
}

class BookWrapper: ObservableObject {
    @Published var book: Book

    init(book: Book) {
        self.book = book
    }
}

class DetailsView: UIViewController, DetailsViewProtocol {

    typealias PresenterType = DetailsPresenterProtocol
    var presenter: PresenterType?
    
    private var hostingController: UIHostingController<DetailsViewContent>?
    private var bookWrapper: BookWrapper!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let presenter = presenter else { return }
        bookWrapper = BookWrapper(book: presenter.book)
        reloadContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.refreshBookFromDB()
        bookWrapper.book = presenter?.book ?? bookWrapper.book
        reloadContent()
    }

    private func reloadContent() {
        guard let presenter = presenter else { return }
        
        let notes = presenter.fetchNotes()

        let contentView = DetailsViewContent(
            bookWrapper: bookWrapper,
            notes: notes,
            onAddNote: { [weak self] text in
                guard let self = self else { return }
                self.presenter?.addNote(text: text)
                self.reloadContent()
            },
            onDeleteNote: { [weak self] note in
                guard let self = self else { return }
                self.presenter?.deleteNote(note)
                self.reloadContent()
            },
            onStatusChange: { [weak self] newStatus in
                guard let self = self else { return }
                self.presenter?.updateBookStatus(newStatus)
                self.reloadContent()
            }, onBack: {
                self.navigationController?.popViewController(animated: true)
            }, onEditDescription: { book in
                let viewController = Builder.createAddDetailsView(book: .coreData(presenter.book))
                self.navigationController?.pushViewController(viewController, animated: true)
                
            },
            onDeleteBook: { [weak self] book in
                guard let self = self else { return }
                presenter.deleteBook(book)
                self.navigationController?.popViewController(animated: true)
            }
        )

        if let hosting = hostingController {
            hosting.rootView = contentView
        } else {
            let hosting = UIHostingController(rootView: contentView)
            hostingController = hosting
            addChild(hosting)
            hosting.view.frame = view.bounds
            view.addSubview(hosting.view)
            hosting.didMove(toParent: self)
        }


    }
}
