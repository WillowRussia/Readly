//
//  OnboardingView.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//

import UIKit
import SwiftUI

protocol OnboardingViewProtocol: BaseViewProtocol {
    
}

class OnboardingView: UIViewController, OnboardingViewProtocol {
    typealias PresenterType = OnboardingPresenterProtocol
    var presenter: PresenterType?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = OnboardingViewContent(slides: presenter?.mockData ?? []) { [weak self] in
            guard let self = self else { return }
            presenter?.startApp()

        }
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.bounds
        view.addSubview(content.view)
        content.didMove(toParent: self)

    }


}
