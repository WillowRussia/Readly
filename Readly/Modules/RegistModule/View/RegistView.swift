//
//  RegistView.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//

import UIKit
import SwiftUI

protocol RegistViewProtocol: BaseViewProtocol{}

class RegistView: UIViewController, RegistViewProtocol {
    typealias PresenterType = RegistPresenterProtocol
    var presenter: PresenterType?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = RegistViewContent{
            print($0)
        }
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }


}
