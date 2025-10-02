//
//  MainView.swift
//  Readly
//
//  Created by Илья Востров on 09.03.2025.
//

import UIKit
import SwiftUI

protocol MainViewProtocol: AnyObject {
    func display(viewModel: MainViewModel)
}

class MainViewObservableModel: ObservableObject {
    @Published var userName: String = ""
    @Published var booksByStatus: [BookStatus : [Book]] = [:]
}

final class MainView: UIViewController, MainViewProtocol {
    
    var presenter: MainPresenterProtocol?
    private var observableModel = MainViewObservableModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    private func setupUI() {
        let contentView = MainViewContent(
            viewModel: observableModel
        ) { [weak self] in
            self?.presenter?.didTapAddBook()
        } goToDetailsView: { [weak self] book in
            self?.presenter?.didSelect(book: book)
        }
        
        let hostingController = UIHostingController(rootView: contentView)
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
    
    func display(viewModel: MainViewModel) {
        observableModel.userName = viewModel.userName
        observableModel.booksByStatus = viewModel.booksByStatus
    }
}
