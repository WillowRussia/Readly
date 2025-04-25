//
//  DetailsPresenter.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//
import Foundation
protocol BookListPresenterProtocol: AnyObject {
    var bookList: [JsonBookModelItem]? { get }
    var bookTitle: String { get }
}

class BookListPresenter: BookListPresenterProtocol {
    weak var view: (any BookListViewProtocol)?
    var bookList: [JsonBookModelItem]?
    var bookTitle: String
    
    init(view: any BookListViewProtocol, bookList: [JsonBookModelItem], bookTitle: String){
        self.view = view
        self.bookList = bookList
        self.bookTitle = bookTitle
    }
    
}
