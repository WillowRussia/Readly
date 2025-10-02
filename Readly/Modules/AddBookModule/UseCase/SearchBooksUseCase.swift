//
//  SearchBooksUseCase.swift
//  Readly
//
//  Created by Илья Востров on 02.10.2025.
//


import Foundation

typealias SearchBooksUseCaseCompletionHandler = (Swift.Result<[JsonBookModelItem], Error>) -> Void

protocol SearchBooksUseCase {
    func search(parameters: SearchBookParameters, completion: @escaping SearchBooksUseCaseCompletionHandler)
}

final class SearchBooksUseCaseImplementation: SearchBooksUseCase {
    private let booksGateway: BooksGateway
    
    init(booksGateway: BooksGateway) {
        self.booksGateway = booksGateway
    }
    
    func search(parameters: SearchBookParameters, completion: @escaping SearchBooksUseCaseCompletionHandler) {
        guard parameters.title.count > 2 else {
            completion(.failure(SearchBooksError.titleTooShort))
            return
        }
        
        self.booksGateway.fetchBooks(parameters: parameters, completion: completion)
    }
}

struct SearchBookParameters {
    let title: String
}

enum SearchBooksError: Error, LocalizedError {
    case titleTooShort
    var errorDescription: String? { "Название книги должно содержать минимум 2 символа" }
}
