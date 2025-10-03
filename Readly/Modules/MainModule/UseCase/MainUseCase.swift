//
//  MainScreenData.swift
//  Readly
//
//  Created by Илья Востров on 28.09.2025.
//


import Foundation

struct MainScreenData {
    let userName: String
    let booksByStatus: [BookStatus: [Book]]
}

protocol FetchMainScreenDataUseCase {
    func execute() -> MainScreenData
}

final class FetchMainScreenDataUseCaseImplementation: FetchMainScreenDataUseCase {
    private let userGateway: MainUserGateway
    private let booksGateway: BookGateway
    
    init(userGateway: MainUserGateway, booksGateway: BookGateway) {
        self.userGateway = userGateway
        self.booksGateway = booksGateway
    }
    
    func execute() -> MainScreenData {
        let userName = userGateway.getName() ?? "Пользователь"
        
        let allBooks = booksGateway.fetchBooks()
        
        let booksByStatus = Dictionary(grouping: allBooks, by: { BookStatus(rawValue: $0.status) ?? .read })
        
        return MainScreenData(userName: userName, booksByStatus: booksByStatus)
    }
}
