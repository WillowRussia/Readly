//
//  BookHeader.swift
//  Readly
//
//  Created by Илья Востров on 11.05.2025.
//

import SwiftUI

struct BookHeader: View {
    var book: Book
    @Binding var offsetTop: CGFloat
    @Binding var showTitle: Bool
    var onStatusChange: (BookStatus) -> Void

    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { proxy in
                let minY = proxy.frame(in: .global).minY

                CoverFromFile(book: book)
                    .scaledToFill()
                    .frame(maxWidth: proxy.size.width)
                    .frame(height: 400 + (minY > 0 ? minY : 0))
                    .clipped()
                    .overlay(Color(.appBlue).opacity(0.4))
                    .offset(y: minY > 0 ? -minY : 0)
                    .onChange(of: minY) { newValue in
                        offsetTop = newValue
                        withAnimation {
                            showTitle = newValue < -190
                        }
                    }
            }
            .frame(height: 400)

            VStack(spacing: 15) {
                CoverFromFile(book: book)
                    .frame(width: 143, height: 212)
                    .clipShape(.rect(cornerRadius: 5))

                VStack(spacing: 2) {
                    Text(book.name)
                        .font(type: .bold, size: 20)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .minimumScaleFactor(16.0 / 20.0)

                    Text(book.author)
                        .font(type: .medium, size: 16)
                        .frame(width: UIScreen.main.bounds.width - 60)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .minimumScaleFactor(14.0 / 16.0)
                }

                BookStatusButton(status: BookStatus(rawValue: book.status) ?? .read, action: onStatusChange)
            }
            .padding(.top, 55)
        }
    }
}
