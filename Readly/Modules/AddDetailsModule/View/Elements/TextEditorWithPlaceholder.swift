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
    @ObservedObject var viewModel: AddDetailsObservableModel
    let completion: () -> ()

    var body: some View {
        ZStack(alignment: .topLeading) {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2.0)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 10)
            } else {
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
                    .overlay(alignment: .topTrailing) {
                        Button {
                            completion()
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
        }
        .scrollContentBackground(.hidden)
        .frame(height: 180)
        .background(.appDark)
        .clipShape(.rect(cornerRadius: 10))
    }
}
