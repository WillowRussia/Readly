//
//  DetailsPresenter.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import UIKit

protocol AddDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapGenerateDescription()
    func didTapSave(parameters: SaveBookParameters)
    func didTapBack()
}

final class AddDetailsPresenter: AddDetailsPresenterProtocol {
    private weak var view: AddDetailsViewProtocol?
    private let router: AddDetailsRouter
    private let generateDescUseCase: GenerateBookDescriptionUseCase
    private let saveBookUseCase: SaveBookUseCase
    private let storageManager = StorageManager()
    
    private let bookSource: BookSource
    
    init(view: AddDetailsViewProtocol,
         router: AddDetailsRouter,
         generateDescUseCase: GenerateBookDescriptionUseCase,
         saveBookUseCase: SaveBookUseCase,
         bookSource: BookSource) {
        self.view = view
        self.router = router
        self.generateDescUseCase = generateDescUseCase
        self.saveBookUseCase = saveBookUseCase
        self.bookSource = bookSource
    }
    
    func viewDidLoad() {
        view?.displayInitialData(from: bookSource)
        let viewModel = createViewModel(from: bookSource)
        view?.display(viewModel: viewModel)
    }
    
    func didTapGenerateDescription() {
        view?.showLoading(true)
        let title: String = {
            switch bookSource {
            case .json(let jsonBook): return jsonBook.title ?? ""
            case .coreData(let coreBook): return coreBook.name
            }
        }()
        
        generateDescUseCase.execute(for: title) { [weak self] result in
            guard let self = self else { return }
            self.view?.showLoading(false)
            switch result {
            case .success(let description):
                self.view?.displayGeneratedDescription(description)
            case .failure(let error):
                self.view?.showAlert(title: "Ошибка", message: error.localizedDescription)
            }
        }
    }
    
    func didTapSave(parameters: SaveBookParameters) {
        view?.showLoading(true)
        saveBookUseCase.execute(parameters: parameters) { [weak self] result in
            guard let self = self else { return }
            self.view?.showLoading(false)
            
            switch result {
            case .success:
                switch self.bookSource {
                case .json:
                    self.router.returnToRoot()
                case .coreData:
                    self.router.close()
                }
            case .failure(let error):
                self.view?.showAlert(title: "Ошибка сохранения", message: error.localizedDescription)
            }
        }
    }
    
    func didTapBack() {
        router.close()
    }
    
    private func createViewModel(from source: BookSource) -> AddDetailsViewModel {
            switch source {
            case .json(let jsonBook):
                return AddDetailsViewModel(
                    name: jsonBook.title ?? "",
                    author: jsonBook.author_name?.authorsInOneLine() ?? "",
                    description: "",
                    coverImage: .defaultCover
                )
                
            case .coreData(let book):
                var coverImage: UIImage = .defaultCover
                if let data = storageManager.getCover(bookId: book.id) {
                    coverImage = UIImage(data: data) ?? .defaultCover
                }
                
                return AddDetailsViewModel(
                    name: book.name,
                    author: book.author,
                    description: book.bookDescription,
                    coverImage: coverImage
                )
            }
        }
}
