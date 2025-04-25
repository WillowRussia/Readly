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
    func saveBook()
    func back()
    func createText()
}

class AddDetailsViewModel: ObservableObject {
    @Published var bookDescription: String = ""
    
}

class AddDetailsView: UIViewController, AddDetailsViewProtocol, AddDetailsViewDelegate {
    
    typealias PresenterType = AddDetailsPresenterProtocol
    var presenter: PresenterType?
    private let viewModel = AddDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = AddDetailsViewContent(book: presenter!.book, delegate: self, viewModel: presenter!.viewModel)
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
    
    func saveBook() {
        //
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func createText() {
//        presenter?.viewModel.bookDescription = "qwerty"
        presenter?.generateBookDescription()
    }
    
}
