//
//  DetailsView.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import UIKit
import SwiftUI

class DetailsObservableModel: ObservableObject {
    @Published var book: Book
    @Published var notes: [Note]

    init(book: Book, notes: [Note]) {
        self.book = book
        self.notes = notes
    }
}

protocol DetailsViewProtocol: AnyObject {
    func setup(model: DetailsObservableModel)
}

final class DetailsView: UIViewController, DetailsViewProtocol {
    
    var presenter: DetailsPresenterProtocol?
    private var hostingController: UIHostingController<DetailsViewContent>?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    func setup(model: DetailsObservableModel) {
        let contentView = DetailsViewContent(
            observableModel: model,
            onAddNote: { [weak self] text in self?.presenter?.addNote(text: text) },
            onDeleteNote: { [weak self] note in self?.presenter?.deleteNote(note) },
            onStatusChange: { [weak self] status in self?.presenter?.updateBookStatus(status) },
            onBack: { [weak self] in self?.presenter?.didTapBack() },
            onEdit: { [weak self] in self?.presenter?.didTapEdit() },
            onDeleteBook: { [weak self] in self?.presenter?.didTapDelete() }
        )
        
        let hosting = UIHostingController(rootView: contentView)
        self.hostingController = hosting
        
        addChild(hosting)
        hosting.view.frame = view.bounds
        view.addSubview(hosting.view)
        hosting.didMove(toParent: self)
    }
}
