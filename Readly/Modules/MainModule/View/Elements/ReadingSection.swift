//
//  ReadingSection.swift
//  Readly
//
//  Created by Илья Востров on 10.05.2025.
//

import SwiftUI

struct ReadingSection: View {
    var books: [Book]
    var goToDetailsView: (Book) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Читаю")
                .font(type: .bold, size: 22)
                .foregroundStyle(.white)
                .padding(.horizontal, 25)
            if books != [] {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(books) { book in
                            Button {
                                goToDetailsView(book)
                            } label: {
                                CoverFromFile(book: book)
                                    .frame(width: 143, height: 212)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                
                            }
                        }
                    }
                }
                .padding(.horizontal, 25)
            } else {
                EmptyBooksView(title: "Вы сейчас не читаете", subtitle: "Попробуйте добавить пару новых книг", bookStyle: .bookFill)
            }
        }
    }
}

