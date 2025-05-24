//
//  DetailsPresenter.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

protocol DetailsPresenterProtocol: AnyObject {
    var book: Book { get set }
    func fetchNotes() -> [Note]
    func addNote(text: String)
    func deleteNote(_ note: Note)
    func updateBookStatus(_ status: BookStatus)
    func deleteBook(_ book: Book)
    func refreshBookFromDB()
}

class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: (any DetailsViewProtocol)?
    var book: Book
    let dbManager = DataBaseManager.shared
    
    init(view: any DetailsViewProtocol, book: Book){
        self.view = view
        self.book = book
    }
    
    func fetchNotes() -> [Note] {
        return dbManager.getNotes(for: book)
    }
    
    func addNote(text: String) {
        dbManager.addNote(to: book, text: text)
    }
    
    func deleteNote(_ note: Note) {
        dbManager.deleteNote(note, from: book)
    }
    
    func refreshBookFromDB() {
        guard let refreshed = dbManager.getBook(by: book.objectID) else { return }
        book = refreshed
    }

    
    func updateBookStatus(_ status: BookStatus) {
        book.status = status.rawValue
        DataBaseManager.shared.saveContext()
    }
    
    func deleteBook(_ book: Book) {
        dbManager.deleteBook(book)
    }

}
