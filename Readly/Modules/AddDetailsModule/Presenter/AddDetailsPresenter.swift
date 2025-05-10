//
//  DetailsPresenter.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//
import Foundation

protocol AddDetailsPresenterProtocol: AnyObject {
    var book: JsonBookModelItem { get }
    var viewModel: AddDetailsViewModel { get set }
    func generateBookDescription()
    func createBook(imageType: ImageType, bookName: String, bookAuthor: String, bookDescription: String, completion: @escaping (Swift.Result<Bool, Error>) -> ())
}

class AddDetailsPresenter: AddDetailsPresenterProtocol {
    
    var book: JsonBookModelItem
    private let dbManger = DataBaseManager.shared
    private let manager = DetailsNetworkManager.shared
    var viewModel = AddDetailsViewModel()
    weak var view: (any AddDetailsViewProtocol)?
    
    init(view: any AddDetailsViewProtocol, book: JsonBookModelItem){
        self.view = view
        self.book = book
    }
    
    func generateBookDescription() {
        manager.sendRequest(bookTitle: book.title ?? "") { [weak self] text in
            guard let self = self else { return }
            switch text {
            case .success (let success):
                DispatchQueue.main.async {
                    self.viewModel.bookDescription = success
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func createBook(imageType: ImageType, bookName: String, bookAuthor: String, bookDescription: String, completion: @escaping (Swift.Result<Bool, Error>) -> ()) {
        
        switch imageType {
        case .local(let image):
            let imageData = image.jpegData(compressionQuality: 1)!
            dbManger.createBook(name: bookName, author: bookAuthor, cover: imageData, description: bookDescription)
            completion(.success(true))
        case .network(let urlString):
            if let urlString, let url = URL(string: "https://covers.openlibrary.org/b/id/\(urlString)-M.jpg"){
                manager.loadCover(url: url) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let imageData):
                        self.dbManger.createBook(name: bookName, author: bookAuthor, cover: imageData, description: bookDescription)
                        completion(.success(true))
                    case .failure(let failure):
                        let err = failure as? SaveError
                        DispatchQueue.main.async {
                            self.viewModel.isAddError = true
                        }
                    }
                }
            }
        }
    }
}
