//
//  CategorySection.swift
//  Readly
//
//  Created by Илья Востров on 10.05.2025.
//

import SwiftUI

struct CategorySection: View {
    @Binding var selectedCategory: SelectedCategory
    @ObservedObject var viewModel: MainViewModel
    var goToDetailsView: (Book) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 26) {
            HStack(alignment: .bottom) {
                Button {
                    selectedCategory = .willRead
                } label: {
                    createButtonText(text: "Прочитаю", category: .willRead, selectedCategory: selectedCategory)
                }
                
                Button {
                    selectedCategory = .didRead
                } label: {
                    createButtonText(text: "Прочитал", category: .didRead, selectedCategory: selectedCategory)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            switch selectedCategory {
            case .willRead:
                VStack {
                    if let willReadBooks = viewModel.books[BookStatus.willRead], willReadBooks != [] {
                        ForEach(willReadBooks) { book in
                            BookItem(book: book, goToDetailsView: goToDetailsView)
                        }
                    } else {
                        EmptyBooksView(title: "Список книг пуст", subtitle: "Попробуйте добавить пару новых книг", bookStyle: .booksVerticalFill)
                    }
                }
            case .didRead:
                VStack {
                    if let didReadBooks = viewModel.books[BookStatus.didRead], didReadBooks != [] {
                        ForEach(didReadBooks) { book in
                            BookItem(book: book, goToDetailsView: goToDetailsView)
                        }
                    } else {
                        EmptyBooksView(title: "Список книг пуст", subtitle: "Попробуйте добавить пару новых книг", bookStyle: .booksVerticalFill)
                    }
                }
            }
        }
        .padding(.horizontal, 25)
    }
    
    func createButtonText(text: String, category: SelectedCategory, selectedCategory: SelectedCategory) -> some View {
        let condition = selectedCategory == category
        return Text(text)
            .font(type: condition ? .bold : .regular, size: condition ? 22 : 18)
            .foregroundStyle(condition ? .white : .appGray)
    }
}

enum SelectedCategory {
    case willRead
    case didRead
}
