//
//  BaseTextView.swift
//  Readly
//
//  Created by Илья Востров on 09.03.2025.
//

import SwiftUI

struct BaseTextView: View {
    var placeholder: String
    @Binding var text: String
    var body: some View {
        TextField(placeholder, text: $text)
            .placeholder(when: text.isEmpty) {
                Text(placeholder)
                    .foregroundColor(.appGray)
                    .padding(.leading, 2)
            }
            .frame (maxWidth: .infinity)
            .frame(height: 52)
            .padding(.horizontal, 10)
            .background(.appDark)
            .foregroundStyle(.white)
            .clipShape(.rect (cornerRadius: 10))
    }
}

