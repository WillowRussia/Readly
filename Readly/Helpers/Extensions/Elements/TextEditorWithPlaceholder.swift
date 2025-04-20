//
//  TextEditorWithPlaceholder.swift
//  Readly
//
//  Created by Илья Востров on 16.04.2025.
//


import SwiftUI

struct TextEditorWithPlaceholder: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.appGray)
                    .font(type: .regular, size: 18)
                    .padding(.top, 12)
                    .padding(.leading, 8)
            }
            
            TextEditor(text: $text)
                .font(type: .regular, size: 18)
                .foregroundColor(.white)
                .overlay(alignment: .topTrailing){
                    Button {
                        //
                    } label: {
                        Image(systemName: "wand.and.stars")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 21, height: 21)
                            .padding(.top, 5)
                            .padding(.trailing, 5)
                            .foregroundStyle(.white)
                            .clipped()
                    }
                }
                .padding(4)

        }
        .scrollContentBackground(.hidden)
        .frame(height: 114)
        .background(.appDark)
        .clipShape(.rect(cornerRadius: 10))

    }
}
