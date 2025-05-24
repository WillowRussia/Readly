//
//  EmptyBooksView.swift
//  Readly
//
//  Created by Илья Востров on 22.04.2025.
//
import SwiftUI

struct EmptyBooksView: View {
    let title: String
    let subtitle: String
    var bookStyle: BookStyle
    var body: some View {
        VStack(spacing: 10) {
            switch bookStyle {
            case .booksVerticalFill:
                Image(systemName: "books.vertical.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.gray)
                    .opacity(0.6)
            case .bookFill:
                Image(systemName: "book.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.gray)
                    .opacity(0.6)
            }
            Text(title)
                .font(type: .bold, size: 25)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Text(subtitle)
                .font(size: 16)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mainBackground)
    }
}

enum BookStyle{
    case booksVerticalFill
    case bookFill
    
}
