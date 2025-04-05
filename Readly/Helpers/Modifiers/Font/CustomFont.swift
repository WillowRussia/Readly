//
//  CustomFont.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//

import SwiftUI

struct CustomFont: ViewModifier { // Структура для развертывания
    var font: FontType
    var size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.custom(font.rawValue, size: size))
    }
}
