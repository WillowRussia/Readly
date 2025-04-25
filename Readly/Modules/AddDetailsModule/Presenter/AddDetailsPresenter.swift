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
}

class AddDetailsPresenter: AddDetailsPresenterProtocol {
    
    weak var view: (any AddDetailsViewProtocol)?
    var book: JsonBookModelItem
    private let manager = TextNetworkManager.shared
    var viewModel = AddDetailsViewModel()
    
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
}
