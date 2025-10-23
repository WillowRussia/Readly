//
//  OnboardingSlide.swift
//  Readly
//
//  Created by Илья Востров on 28.09.2025.
//


import Foundation

struct OnboardingSlide: Identifiable {
    let id: UUID = UUID()
    let title: String
    let image: String
    let description: String
    
    static var productionData: [OnboardingSlide] {
        [
            OnboardingSlide(title: "Открывайте мир знаний!", image: "brain1", description: "Readly — ваш помощник в мире книг! Здесь вы найдете вдохновение, новые идеи и захватывающие истории. Начните свое интеллектуальное путешествие прямо сейчас!"),
            OnboardingSlide(title: "Учитесь с комфортом", image: "brain2", description: "Читайте любимые книги в удобном формате. Закладки, заметки и краткая выжимка помогут вам легко усваивать информацию!"),
            OnboardingSlide(title: "Чтение — это удовольствие!", image: "brain3", description: "Погрузитесь в удивительный мир литературы без отвлекающих факторов. Настраивайте шрифт, фон и режим чтения под себя!"),
            OnboardingSlide(title: "Readly — ваш умный спутник", image: "brain4", description: "Создавайте собственную библиотеку, отслеживайте прогресс и получайте персональные рекомендации. Откройте новые горизонты вместе с Readly!")
        ]
    }
}
