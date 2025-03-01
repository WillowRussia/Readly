//
//  OnboardingData.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//

import Foundation

struct OnboardinData: Identifiable {
    var id: UUID = UUID()
    var title: String
    var image: String
    var description: String
    
    static var mockData: [OnboardinData] {
    [
        OnboardinData(title: "Открывайте мир знаний!", image: "brain1", description: "Readly — ваш помощник в мире книг! Здесь вы найдете вдохновение, новые идеи и захватывающие истории. Начните свое интеллектуальное путешествие прямо сейчас!" ),
        OnboardinData(title: "Учитесь с комфортом", image: "brain2", description: "Читайте любимые книги в удобном формате. Закладки, заметки и краткая выжимка помогут вам легко усваивать информацию!" ),
        OnboardinData(title: "Чтение — это удовольствие!", image: "brain3", description: "Погрузитесь в удивительный мир литературы без отвлекающих факторов. Настраивайте шрифт, фон и режим чтения под себя!" ),
        OnboardinData(title: "Readly — ваш умный спутник", image: "brain4", description: "Создавайте собственную библиотеку, отслеживайте прогресс и получайте персональные рекомендации. Откройте новые горизонты вместе с Readly!" )
    ]
    
    }
   
}
