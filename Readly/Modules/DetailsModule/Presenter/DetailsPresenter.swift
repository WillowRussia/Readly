//
//  DetailsPresenter.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import Foundation

protocol DetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func addNote(text: String)
    func deleteNote(_ note: Note)
    func updateBookStatus(_ status: BookStatus)
    func didTapBack()
    func didTapEdit()
    func didTapDelete()
}

final class DetailsPresenter: DetailsPresenterProtocol {
    
    private weak var view: DetailsView?
    private let router: DetailsRouter
    
    private let fetchDetailsUC: FetchBookDetailsUseCase
    private let manageNotesUC: ManageNotesUseCase
    private let updateStatusUC: UpdateBookStatusUseCase
    private let deleteBookUC: DeleteBookUseCase
    
    private var book: Book
    private var observableModel: DetailsObservableModel?
    
    init(view: DetailsView,
         router: DetailsRouter,
         book: Book,
         fetchDetailsUC: FetchBookDetailsUseCase,
         manageNotesUC: ManageNotesUseCase,
         updateStatusUC: UpdateBookStatusUseCase,
         deleteBookUC: DeleteBookUseCase) {
        self.view = view
        self.router = router
        self.book = book
        self.fetchDetailsUC = fetchDetailsUC
        self.manageNotesUC = manageNotesUC
        self.updateStatusUC = updateStatusUC
        self.deleteBookUC = deleteBookUC
    }
    
    func viewDidLoad() {
        let notes = fetchDetailsUC.fetchNotes(for: book)
        let model = DetailsObservableModel(book: book, notes: notes)
        self.observableModel = model
        view?.setup(model: model)
    }
    
    func viewWillAppear() {
        refreshData()
    }
    
    func addNote(text: String) {
        manageNotesUC.addNote(text: text, to: book)
        refreshData()
    }
    
    func deleteNote(_ note: Note) {
        manageNotesUC.deleteNote(note)
        refreshData()
    }
    
    func updateBookStatus(_ status: BookStatus) {
        updateStatusUC.execute(for: book, newStatus: status)
        refreshData()
    }
    
    func didTapBack() {
        router.close()
    }
    
    func didTapEdit() {
        router.navigateToEdit(book: book)
    }
    
    func didTapDelete() {
        deleteBookUC.execute(book)
        router.close()
    }
    
    private func refreshData() {
        if let refreshedBook = fetchDetailsUC.fetchBook(by: book.objectID) {
            self.book = refreshedBook
            observableModel?.book = refreshedBook
        }
        let notes = fetchDetailsUC.fetchNotes(for: book)
        observableModel?.notes = notes
    }
}
