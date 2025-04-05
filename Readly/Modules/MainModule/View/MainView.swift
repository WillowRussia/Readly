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

class MainView: UIViewController, MainViewProtocol {
    
    typealias PresenterType = MainPresenterProtocol
    var presenter: PresenterType?

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentView = MainViewContent(name: presenter?.name ?? "")
        
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.bounds
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
    

}
