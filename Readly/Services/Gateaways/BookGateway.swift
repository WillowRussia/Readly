//
//  BookGateway 2.swift
//  Readly
//
//  Created by Илья Востров on 03.10.2025.
//


import Foundation
import UIKit
import CoreData

protocol BookGateway {
    func fetchBooks() -> [Book]
    func createBook(name: String, author: String, description: String, coverData: Data) -> Book?
    func updateBook(_ book: Book, name: String, author: String, description: String, coverData: Data?)
    func deleteBook(_ book: Book)
    func getBook(by id: NSManagedObjectID) -> Book?
    func getNotes(for book: Book) -> [Note]
    func addNote(text: String, to book: Book)
    func deleteNote(_ note: Note)
    func updateBookStatus(for book: Book, newStatus: BookStatus)
}

final class BookGatewayImplementation: BookGateway {
    
    private let coreDataManager = CoreDataManager.shared
    private let storageManager =  StorageManager()
    
    init() {}
    
    func fetchBooks() -> [Book] {
        return coreDataManager.fetchBooks()
    }
    
    func createBook(name: String, author: String, description: String, coverData: Data) -> Book? {
        guard let newBook = coreDataManager.createBook(
            name: name,
            author: author,
            description: description,
            coverURL: "cover.jpeg"
        ) else {
            return nil
        }
        storageManager.saveCover(coverData, bookId: newBook.id)
        return newBook
    }
    
    func updateBook(_ book: Book, name: String, author: String, description: String, coverData: Data?) {
        coreDataManager.updateBook(book, name: name, author: author, description: description, coverURL: "cover.jpeg")
        if let coverData = coverData {
            storageManager.saveCover(coverData, bookId: book.id)
        }
    }
    
    func deleteBook(_ book: Book) {
        let bookId = book.id
        coreDataManager.deleteBook(book)
        storageManager.deleteCover(bookId: bookId)
    }
    
    func getBook(by id: NSManagedObjectID) -> Book? {
        return coreDataManager.persistentContainer.viewContext.object(with: id) as? Book
    }
    
    func getNotes(for book: Book) -> [Note] {
        guard let notes = book.notes as? Set<Note> else { return [] }
        return notes.sorted { $0.date > $1.date }
    }
    
    func addNote(text: String, to book: Book) {
        coreDataManager.addNote(to: book, text: text)
    }
    
    func deleteNote(_ note: Note) {
        coreDataManager.deleteNote(note)
    }
    
    func updateBookStatus(for book: Book, newStatus: BookStatus) {
        book.status = newStatus.rawValue
        coreDataManager.saveContext()
    }
}
