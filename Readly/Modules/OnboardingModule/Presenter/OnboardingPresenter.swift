//
//  OnboardingViewPresenter.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//

import Foundation

protocol OnboardingPresenterProtocol: AnyObject {
    func viewDidLoad()
    func startAppButtonPressed()
}

final class OnboardingPresenter: OnboardingPresenterProtocol {
    private weak var view: OnboardingViewProtocol?
    private let fetchSlidesUseCase: FetchOnboardingSlidesUseCase
    private let completeOnboardingUseCase: CompleteOnboardingUseCase
    private let router: OnboardingRouter
    
    init(view: OnboardingViewProtocol,
         fetchSlidesUseCase: FetchOnboardingSlidesUseCase,
         completeOnboardingUseCase: CompleteOnboardingUseCase,
         router: OnboardingRouter) {
        self.view = view
        self.fetchSlidesUseCase = fetchSlidesUseCase
        self.completeOnboardingUseCase = completeOnboardingUseCase
        self.router = router
    }
    
    func viewDidLoad() {
        let slides = fetchSlidesUseCase.execute()
        view?.display(slides: slides)
    }
    
    func startAppButtonPressed() {
        completeOnboardingUseCase.execute()
        router.navigateToMainApp()
    }
}
