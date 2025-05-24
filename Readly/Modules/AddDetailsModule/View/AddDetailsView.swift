//
//  DetailsView.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import UIKit
import SwiftUI

protocol AddDetailsViewProtocol: BaseViewProtocol {
    
}

protocol AddDetailsViewDelegate {
    func saveBook(imageType: ImageType, bookName: String, bookAuthor: String, bookDescription: String)
    func back()
    func createText()
    func goToMainView()
}

class AddDetailsViewModel: ObservableObject {
    @Published var bookDescription: String = ""
    @Published var isAddError: Bool = false
    @Published var isLoading: Bool = false
}

class AddDetailsView: UIViewController, AddDetailsViewProtocol, AddDetailsViewDelegate {
    
    typealias PresenterType = AddDetailsPresenterProtocol
    var presenter: PresenterType?
    private let viewModel = AddDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = AddDetailsViewContent(
            source: presenter!.book,
            delegate: self,
            viewModel: presenter!.viewModel
        )
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
    
    func saveBook(imageType: ImageType, bookName: String, bookAuthor: String, bookDescription: String) {
        presenter?.createOrUpdateBook(
            imageType: imageType,
            bookName: bookName,
            bookAuthor: bookAuthor,
            bookDescription: bookDescription
        ) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let success):
                if success {
                    switch self.presenter?.book {
                    case .json:
                        self.goToMainView()
                    case .coreData( _):
                        self.navigationController?.popViewController(animated: true)
                    case .none:
                        break
                    }
                }
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }

    
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func createText() {
        presenter?.generateBookDescription()
    }
    
    func goToMainView() {
        DispatchQueue.main.async { 
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
