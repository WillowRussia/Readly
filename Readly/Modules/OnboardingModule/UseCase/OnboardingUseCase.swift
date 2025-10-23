//
//  FetchOnboardingSlidesUseCase.swift
//  Readly
//
//  Created by Илья Востров on 28.09.2025.
//


import Foundation

protocol FetchOnboardingSlidesUseCase {
    func execute() -> [OnboardingSlide]
}

final class FetchOnboardingSlidesUseCaseImplementation: FetchOnboardingSlidesUseCase {
    private let gateway: OnboardingDataGateway
    
    init(gateway: OnboardingDataGateway) {
        self.gateway = gateway
    }
    
    func execute() -> [OnboardingSlide] {
        return gateway.fetchSlides()
    }
}


protocol CompleteOnboardingUseCase {
    func execute()
}

final class CompleteOnboardingUseCaseImplementation: CompleteOnboardingUseCase {
    private let windowStateGateway: WindowStateGateway
    
    init(windowStateGateway: WindowStateGateway) {
        self.windowStateGateway = windowStateGateway
    }
    
    func execute() {
        windowStateGateway.save(windowState: .main)
    }
}
