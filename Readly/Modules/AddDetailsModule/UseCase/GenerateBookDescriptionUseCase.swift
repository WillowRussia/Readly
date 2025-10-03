//
//  GenerateBookDescriptionUseCase.swift
//  Readly
//
//  Created by Илья Востров on 02.10.2025.
//


import Foundation
import UIKit

protocol GenerateBookDescriptionUseCase {
    func execute(for bookTitle: String, completion: @escaping (Swift.Result<String, Error>) -> Void)
}

final class GenerateBookDescriptionUseCaseImplementation: GenerateBookDescriptionUseCase {
    private let gateway: BookDetailsGateway
    init(gateway: BookDetailsGateway) { self.gateway = gateway }
    func execute(for bookTitle: String, completion: @escaping (Swift.Result<String, Error>) -> Void) {
        gateway.generateDescription(for: bookTitle, completion: completion)
    }
}

struct SaveBookParameters {
    let source: BookSource
    let imageType: ImageType
    let name: String
    let author: String
    let description: String
}

protocol SaveBookUseCase {
    func execute(parameters: SaveBookParameters, completion: @escaping (EmptyResult) -> Void)
}

final class SaveBookUseCaseImplementation: SaveBookUseCase {
    private let dbGateway: BookGateway
    private let networkGateway: BookDetailsGateway
    
    init(dbGateway: BookGateway, networkGateway: BookDetailsGateway) {
        self.dbGateway = dbGateway
        self.networkGateway = networkGateway
    }
    
    func execute(parameters: SaveBookParameters, completion: @escaping (EmptyResult) -> Void) {
        let saveData = { [weak self] (imageData: Data?) in
            guard let self = self, let imageData = imageData else {
                completion(.failure(NSError(domain: "SaveBookError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Изображение не найдено"])))
                return
            }
            
            switch parameters.source {
            case .json:
                self.dbGateway.createBook(name: parameters.name, author: parameters.author, cover: imageData, description: parameters.description)
            case .coreData(let existingBook):
                self.dbGateway.updateBook(existingBook, name: parameters.name, author: parameters.author, description: parameters.description, cover: imageData)
            }
            completion(.success(()))
        }
        
        switch parameters.imageType {
        case .local(let image):
            saveData(image.jpegData(compressionQuality: 1.0))
        case .network(let urlString):
            guard let urlString = urlString, let url = URL(string: "https://covers.openlibrary.org/b/id/\(urlString)-M.jpg") else {
                saveData(nil)
                return
            }
            networkGateway.downloadCover(from: url) { result in
                switch result {
                case .success(let data):
                    saveData(data)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
