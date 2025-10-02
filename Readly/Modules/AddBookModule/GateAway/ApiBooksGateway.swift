//
//  ApiBooksGateway.swift
//  Readly
//
//  Created by Илья Востров on 02.10.2025.
//


import Foundation

protocol ApiBooksGateway: BooksGateway {}

final class ApiBooksGatewayImplementation: ApiBooksGateway {
    private let networkManager: BookNetworkManager
    
    init(networkManager: BookNetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchBooks(parameters: SearchBookParameters, completion: @escaping FetchBooksGatewayCompletionHandler) {
        networkManager.serachBookRequest(q: parameters.title) { (result: Swift.Result<[JsonBookModelItem], Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
