//
//  MainPresenter.swift
//  Readly
//
//  Created by Илья Востров on 09.03.2025.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    var name: String { get }
    var readingBooks: [Book] { get }
    var unreadBooks: [Book] { get }
    var willReadBooks: [Book] { get }
    func fetch()
}

class MainPresenter: MainPresenterProtocol {
    
    weak var view: (any MainViewProtocol)?
    private var bookService = DataBaseManager.shared
    var name: String
    var readingBooks: [Book] = []
    var unreadBooks: [Book] = []
    var willReadBooks: [Book] = []
    
    init(view: any MainViewProtocol) {
        self.view = view
        self.name = UserDefaults.standard.string(forKey: "name") ?? ""
        fetch()
    }
    
    func setBooks(newValue: [Book]) {
        readingBooks = newValue.filter{ $0.status == BookStatus.read.rawValue }
        unreadBooks = newValue.filter{ $0.status == BookStatus.didRead.rawValue }
        willReadBooks = newValue.filter{ $0.status == BookStatus.willRead.rawValue }
    }
    
    func fetch() {
        bookService.fetchBooks()
        setBooks(newValue: bookService.books)
    }
    
}
