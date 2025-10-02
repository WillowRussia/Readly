//
//  BooksDatabaseGateway.swift
//  Readly
//
//  Created by Илья Востров on 28.09.2025.
//


import Foundation

protocol BooksDatabaseGateway {
    func fetchBooks() -> [Book]
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
}
