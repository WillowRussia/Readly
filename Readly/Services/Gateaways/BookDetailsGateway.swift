//
//  BookDetailsGateway.swift
//  Readly
//
//  Created by Илья Востров on 02.10.2025.
//


import Foundation

protocol BookDetailsGateway {
    func generateDescription(for bookTitle: String, completion: @escaping (Swift.Result<String, Error>) -> Void)
    func downloadCover(from url: URL, completion: @escaping (Swift.Result<Data, Error>) -> Void)
}

final class NetworkBookDetailsGateway: BookDetailsGateway {
    private let networkManager = DetailsNetworkManager.shared
    
    func generateDescription(for bookTitle: String, completion: @escaping (Swift.Result<String, Error>) -> Void) {
        networkManager.sendRequest(bookTitle: bookTitle, completion: completion)
    }
    
    func downloadCover(from url: URL, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        networkManager.loadCover(url: url, completion: completion)
    }
}
