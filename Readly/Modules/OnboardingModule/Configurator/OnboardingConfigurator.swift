//
//  OnboardingConfigurator.swift
//  Readly
//
//  Created by Илья Востров on 28.09.2025.
//


import Foundation

protocol OnboardingConfigurator {
    func configure(viewController: OnboardingView)
}

final class OnboardingConfiguratorImplementation: OnboardingConfigurator {
    func configure(viewController: OnboardingView) {

        let onboardingDataGateway = LocalOnboardingDataGateway()
        let windowStateGateway = UserDefaultsWindowStateGateway()
        
        let fetchSlidesUseCase = FetchOnboardingSlidesUseCaseImplementation(gateway: onboardingDataGateway)
        let completeOnboardingUseCase = CompleteOnboardingUseCaseImplementation(windowStateGateway: windowStateGateway)
        
        let router = OnboardingRouterImplementation(viewController: viewController)
        
        let presenter = OnboardingPresenter(
            view: viewController,
            fetchSlidesUseCase: fetchSlidesUseCase,
            completeOnboardingUseCase: completeOnboardingUseCase,
            router: router
        )
        
        viewController.presenter = presenter
    }
}
