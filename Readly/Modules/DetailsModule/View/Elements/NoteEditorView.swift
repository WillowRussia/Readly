//
//  NoteEditorView.swift
//  Readly
//
//  Created by Илья Востров on 11.05.2025.
//

import SwiftUI

struct NoteEditorView: View {
    var placeholder: String
    @Binding var text: String

    @State private var dynamicHeight: CGFloat = 52

    var body: some View {
        ZStack(alignment: .topLeading) {
            
            if text.isEmpty {
                Text(placeholder)
                    .font(type: .regular, size: 18)
                    .foregroundColor(.appGray)
                    .padding(.top, 15)
                    .padding(.leading, 19)
                    .zIndex(2)
            }
            TextEditor(text: $text)
                .frame(minHeight: 52, maxHeight: dynamicHeight)
                .padding(.top, 10)
                .padding(.leading, 15)
                .background(.appDark)
                .foregroundColor(.white)
                .onChange(of: text) { _ in
                    recalculateHeight()
                }

        }
        .scrollContentBackground(.hidden)
        .background(.appDark)
        .onAppear {
            recalculateHeight()
        }
        .clipShape(.rect(cornerRadius: 10))
    }

    private func recalculateHeight() {
        let textView = UITextView()
        textView.text = text
        textView.font = UIFont.systemFont(ofSize: 17)
        let fittingSize = CGSize(width: UIScreen.main.bounds.width - 60, height: .greatestFiniteMagnitude)
        let size = textView.sizeThatFits(fittingSize)
        dynamicHeight = min(max(size.height + 20, 52), 180)
    }
}
