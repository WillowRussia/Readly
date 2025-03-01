//
//  SlideItem.swift
//  Readly
//
//  Created by Илья Востров on 01.03.2025.
//

import SwiftUI

struct SlideItem: View {
    var item : OnboardinData
    var tag: Int
    var body: some View {
        VStack(spacing: 39) {
            Image(item.image)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width - 100, height:  UIScreen.main.bounds.width - 100)
                .clipped()
            Text(item.description)
                .font(.system(size: 16))
                .foregroundStyle(.white)
                .padding(.horizontal, 40)
        }
        .tag(tag)
    }
}
