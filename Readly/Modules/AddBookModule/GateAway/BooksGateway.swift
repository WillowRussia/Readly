//
//  BooksGateway.swift
//  Readly
//
//  Created by Илья Востров on 02.10.2025.
//


import Foundation

typealias FetchBooksGatewayCompletionHandler = (Swift.Result<[JsonBookModelItem], Error>) -> Void

protocol BooksGateway {
    func fetchBooks(parameters: SearchBookParameters, completion: @escaping FetchBooksGatewayCompletionHandler)
}
