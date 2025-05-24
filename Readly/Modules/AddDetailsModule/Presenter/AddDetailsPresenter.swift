//
//  DetailsPresenter.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//
import Foundation

protocol AddDetailsPresenterProtocol: AnyObject {
        var book: BookSource { get }
        var viewModel: AddDetailsViewModel { get set }

        func generateBookDescription()
        func createOrUpdateBook(
            imageType: ImageType,
            bookName: String,
            bookAuthor: String,
            bookDescription: String,
            completion: @escaping (Swift.Result<Bool, Error>) -> Void
        )
}

class AddDetailsPresenter: AddDetailsPresenterProtocol {

    var book: BookSource
    private let dbManger = DataBaseManager.shared
    private let manager = DetailsNetworkManager.shared
    var viewModel = AddDetailsViewModel()
    weak var view: (any AddDetailsViewProtocol)?

    init(view: any AddDetailsViewProtocol, book: BookSource) {
        self.view = view
        self.book = book
    }

    func generateBookDescription() {
        viewModel.isLoading = true
        let title: String = {
            switch book {
            case .json(let jsonBook): return jsonBook.title ?? ""
            case .coreData(let coreBook): return coreBook.name
            }
        }()
        manager.sendRequest(bookTitle: title) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let desc): self.viewModel.bookDescription = desc
                case .failure(let err): print(err.localizedDescription)
                }
                self.viewModel.isLoading = false
            }
        }
    }

    func createOrUpdateBook(
        imageType: ImageType,
        bookName: String,
        bookAuthor: String,
        bookDescription: String,
        completion: @escaping (Swift.Result<Bool, Error>) -> Void
    ) {
        let saveBookData: (Data?) -> Void = { [weak self] imageData in
            guard let self = self else { return }
            guard let imageData = imageData else { return }

            switch self.book {
            case .json:
                self.dbManger.createBook(name: bookName, author: bookAuthor, cover: imageData, description: bookDescription)
            case .coreData(let existingBook):
                self.dbManger.updateBook(existingBook, name: bookName, author: bookAuthor, description: bookDescription, cover: imageData)
            }
            completion(.success(true))
        }

        switch imageType {
        case .local(let image):
            saveBookData(image.jpegData(compressionQuality: 1))
        case .network(let urlString):
            guard let urlString, let url = URL(string: "https://covers.openlibrary.org/b/id/\(urlString)-M.jpg") else {
                saveBookData(nil)
                return
            }
            manager.loadCover(url: url) { result in
                switch result {
                case .success(let data): saveBookData(data)
                case .failure:
                    DispatchQueue.main.async { self.viewModel.isAddError = true }
                }
            }
        }
    }
}

