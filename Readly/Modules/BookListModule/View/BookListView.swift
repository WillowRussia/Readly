//
//  DetailsView.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import UIKit
import SwiftUI

protocol BookListViewProtocol: BaseViewProtocol {
    
}

class BookListView: UIViewController, BookListViewProtocol {
    
    typealias PresenterType = BookListPresenterProtocol
    var presenter: PresenterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = BookListViewContent()
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
    
}
