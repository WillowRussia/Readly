//
//  OnboardingView.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//

import UIKit
import SwiftUI

protocol OnboardingViewProtocol: AnyObject {
    func display(slides: [OnboardingSlide])
}

final class OnboardingView: UIViewController, OnboardingViewProtocol {
    
    var presenter: OnboardingPresenterProtocol?

    private var hostingController: UIHostingController<OnboardingViewContent>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter?.viewDidLoad()
    }

    func display(slides: [OnboardingSlide]) {
        let contentView = OnboardingViewContent(slides: slides) { [weak self] in
            guard let self = self else { return }
            self.presenter?.startAppButtonPressed()
        }
        
        let hostingController = UIHostingController(rootView: contentView)
        self.hostingController = hostingController
        
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}
