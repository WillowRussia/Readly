//
//  DetailsUseCase.swift
//  Readly
//
//  Created by Илья Востров on 03.10.2025.
//

import Foundation
import CoreData

protocol FetchBookDetailsUseCase {
    func fetchBook(by id: NSManagedObjectID) -> Book?
    func fetchNotes(for book: Book) -> [Note]
}

final class FetchBookDetailsUseCaseImplementation: FetchBookDetailsUseCase {
    private let bookGateway = BookGatewayImplementation.shared
    
    func fetchBook(by id: NSManagedObjectID) -> Book? {
        return bookGateway.getBook(by: id)
    }
    
    func fetchNotes(for book: Book) -> [Note] {
        return bookGateway.getNotes(for: book)
    }
}

protocol UpdateBookStatusUseCase {
    func execute(for book: Book, newStatus: BookStatus)
}

final class UpdateBookStatusUseCaseImplementation: UpdateBookStatusUseCase {
    private let bookGateway = BookGatewayImplementation.shared
    
    func execute(for book: Book, newStatus: BookStatus) {
        bookGateway.updateBookStatus(for: book, newStatus: newStatus)
    }
}

protocol ManageNotesUseCase {
    func addNote(text: String, to book: Book)
    func deleteNote(_ note: Note)
}

final class ManageNotesUseCaseImplementation: ManageNotesUseCase {
    private let bookGateway = BookGatewayImplementation.shared
    
    func addNote(text: String, to book: Book) {
        bookGateway.addNote(text: text, to: book)
    }
    
    func deleteNote(_ note: Note) {
        bookGateway.deleteNote(note)
    }
}

protocol DeleteBookUseCase {
    func execute(_ book: Book)
}

final class DeleteBookUseCaseImplementation: DeleteBookUseCase {
    private let bookGateway = BookGatewayImplementation.shared
    
    func execute(_ book: Book) {
        bookGateway.deleteBook(book)
    }
}
