//
//  DetailsView.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import UIKit
import SwiftUI

protocol AddDetailsViewProtocol: AnyObject {
    func displayInitialData(from source: BookSource)
    func displayGeneratedDescription(_ description: String)
    func showLoading(_ isLoading: Bool)
    func showAlert(title: String, message: String)
    func display(viewModel: AddDetailsViewModel)
}

final class AddDetailsView: UIViewController, AddDetailsViewProtocol {
    
    var presenter: AddDetailsPresenterProtocol?
    private let observableModel = AddDetailsObservableModel()
    private var bookSource: BookSource?
    private var initialViewModel: AddDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func display(viewModel: AddDetailsViewModel) {
            self.initialViewModel = viewModel
            setupUI()
        }
    
    func displayInitialData(from source: BookSource) {
        self.bookSource = source
        setupUI()
    }
    
    func displayGeneratedDescription(_ description: String) {
        observableModel.bookDescription = description
    }
    
    func showLoading(_ isLoading: Bool) {
        observableModel.isLoading = isLoading
    }
    
    private func setupUI() {
        guard let viewModel = initialViewModel else { return }
        guard let bookSource = bookSource else { return }
        
        let contentView = AddDetailsViewContent(
            source: bookSource,
            initialViewModel: viewModel,
            observableModel: observableModel,
            onSave: { [weak self] parameters in
                self?.presenter?.didTapSave(parameters: parameters)
            },
            onBack: { [weak self] in
                self?.presenter?.didTapBack()
            },
            onCreateText: { [weak self] in
                self?.presenter?.didTapGenerateDescription()
            }
        )
        
        let hostingController = UIHostingController(rootView: contentView)
        addChild(hostingController)
        hostingController.view.frame = view.frame
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
    
    func showAlert(title: String, message: String) {
        super.showAlert(title: title, message: message)
    }
}
