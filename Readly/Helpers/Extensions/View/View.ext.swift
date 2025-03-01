//
//  View.ext.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//
import SwiftUI

extension View{
    func font(type: FontType = .regular, size: CGFloat = 14) -> some View { // Использование кастомного шрифта
        modifier(CustomFont(font: type, size: size))
    }
    
    func placeholder<Content: View>( // Добавление placeholder
            when shouldShow: Bool,
            alignment: Alignment = .leading,
            @ViewBuilder placeholder: () -> Content
        ) -> some View {
            ZStack(alignment: alignment) {
                if shouldShow { placeholder() }
                self
            }
        }
}

