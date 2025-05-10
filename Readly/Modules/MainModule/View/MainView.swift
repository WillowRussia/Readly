//
//  MainView.swift
//  Readly
//
//  Created by Илья Востров on 09.03.2025.
//

import UIKit
import SwiftUI

protocol MainViewProtocol: BaseViewProtocol {
    
}

class MainViewModel: ObservableObject {
    @Published var books: [BookStatus : [Book]] = [:]
}

class MainView: UIViewController, MainViewProtocol {
    
    typealias PresenterType = MainPresenterProtocol
    var presenter: PresenterType?
    var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let contentView = MainViewContent(name: presenter?.name ?? "", viewModel: viewModel   ){
            self.navigationToViewController(book: nil)
        } goToDetailsView: { [weak self] book in
            guard let self = self else { return }
            self.navigationToViewController(book: book)
        }
        
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.bounds
        view.addSubview(content.view)
        content.didMove(toParent: self)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter?.fetch()
        let books = [BookStatus.read : presenter?.readingBooks ?? [], BookStatus.didRead : presenter?.unreadBooks ?? [], BookStatus.willRead : presenter?.willReadBooks ?? []]
        viewModel.books = books
    }
    
    private func navigationToViewController(book: Book?){
        if let book {
            let viewController = Builder.createDetailsView(book: book)
        navigationController?.pushViewController(viewController, animated: true)
        } else {
            let viewController = Builder.createAddBookView()
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    
}
