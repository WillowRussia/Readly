//
//  DetailsViewContent.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import SwiftUI

import SwiftUI

struct BookListViewContent: View {
    let books: [JsonBookModelItem]
    let bookTitle: String
    let completion: (JsonBookModelItem?) -> ()
    
    var body: some View {
        ZStack(alignment: .top) {
            NavigationHeader(title: bookTitle) {
                completion(nil)
            }
            .zIndex(1)
            
            if books.isEmpty {
                EmptyBooksView(title: "Книги не найдены", subtitle: "Попробуйте изменить текст запроса", bookStyle: .booksVerticalFill)
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 30) {
                        Text("Результаты поиска")
                            .foregroundStyle(.white)
                            .font(size: 16)
                            .padding(.horizontal, 5)
                        
                        VStack(alignment: .leading, spacing: 23) {
                            ForEach(books, id: \.self) { book in
                                BookListItem(book: book) {
                                    completion(book)
                                }
                            }
                        }
                    }
                }
                .padding(.top, 44)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal, 30)
        .background(.mainBackground)
    }
}
