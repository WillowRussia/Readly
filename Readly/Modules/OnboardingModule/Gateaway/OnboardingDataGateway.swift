//
//  OnboardingDataGateway.swift
//  Readly
//
//  Created by Илья Востров on 28.09.2025.
//


import Foundation

protocol OnboardingDataGateway {
    func fetchSlides() -> [OnboardingSlide]
}

final class LocalOnboardingDataGateway: OnboardingDataGateway {
    func fetchSlides() -> [OnboardingSlide] {
        return OnboardingSlide.productionData
    }
}
