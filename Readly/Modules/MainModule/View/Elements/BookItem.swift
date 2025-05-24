//
//  BookItem.swift
//  Readly
//
//  Created by Илья Востров on 07.04.2025.
//
import SwiftUI

struct BookItem: View {
    var book: Book
    var goToDetailsView: (Book) -> Void

    var body: some View {
        Button {
            goToDetailsView(book)
        } label: {
            HStack(spacing: 13) {
                CoverFromFile(book: book)
                    .frame(width: 94, height: 134)
                    .clipShape(RoundedRectangle(cornerRadius: 3))
                
                VStack(alignment: .leading, spacing: 9) {
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(book.name)
                            .font(type: .bold, size: 14)
                            .lineLimit(1)
                            .truncationMode(.tail)

                        Text(book.author)
                            .font(type: .medium, size: 12)
                            .foregroundStyle(.appGray)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }

                    Text(book.bookDescription)
                        .font(type: .medium, size: 14)
                        .lineLimit(3)
                        .truncationMode(.tail)
                }
                .foregroundStyle(.white)
            }
        }
    }
}


