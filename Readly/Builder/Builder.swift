//
//  Builder.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//

import UIKit

protocol BaseViewProtocol: AnyObject {
    associatedtype PresenterType
    var presenter: PresenterType? {get set}
}

class Builder {
    static private func createView<View: UIViewController & BaseViewProtocol>(viewType: View.Type, presenter: (View) -> View.PresenterType) -> UIViewController{
        let view = View()
        let presenter = presenter(view)
        view.presenter = presenter
        return view
    }
    
    static func createRegistView() -> UIViewController {
        return self.createView(viewType: RegistView.self) { view in
            RegistPresenter(view: view)
        }
    }
    
    static func createOnboardingView() -> UIViewController {
        return self.createView(viewType: OnboardingView.self) { view in
            OnboardingPresenter(view: view)
        }
    }
    
    static func createMainView() -> UIViewController {
        return self.createView(viewType: MainView.self) { view in
            MainPresenter(view: view)
        }
    }
    
    static func createDetailsView() -> UIViewController {
        return self.createView(viewType: DetailsView.self) { view in
            DetailsPresenter(view: view)
        }
    }
    
    static func createAddBookView() -> UIViewController {
        return self.createView(viewType: AddBookView.self) { view in
            AddBookPresenter(view: view)
        }
    }

}
