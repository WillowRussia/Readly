//
//  BooksDatabaseGateway.swift
//  Readly
//
//  Created by Илья Востров on 28.09.2025.
//

import Foundation
import UIKit


protocol BooksDatabaseGateway {
    func fetchBooks() -> [Book]
    func createBook(name: String, author: String, cover: Data, description: String)
    func updateBook(_ book: Book, name: String, author: String, description: String, cover: Data)
}

final class CoreDataBooksDatabaseGateway: BooksDatabaseGateway {
    private let databaseManager: DataBaseManager
    
    init(databaseManager: DataBaseManager = .shared) {
        self.databaseManager = databaseManager
    }
    
    func fetchBooks() -> [Book] {
        databaseManager.fetchBooks()
        return databaseManager.books
    }
    
    func createBook(name: String, author: String, cover: Data, description: String) {
        databaseManager.createBook(name: name, author: author, cover: cover, description: description)
    }
    
    func updateBook(_ book: Book, name: String, author: String, description: String, cover: Data) {
        databaseManager.updateBook(book, name: name, author: author, description: description, cover: cover)
    }
}
