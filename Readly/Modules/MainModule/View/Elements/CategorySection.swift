//
//  CategorySection.swift
//  Readly
//
//  Created by Илья Востров on 10.05.2025.
//

import SwiftUI

struct CategorySection: View {
    @Binding var selectedCategory: BookStatus
    
    @ObservedObject var viewModel: MainViewObservableModel
    
    var goToDetailsView: (Book) -> Void
    
    private var booksForSelectedCategory: [Book] {
        viewModel.booksByStatus[selectedCategory] ?? []
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 26) {
            HStack(alignment: .bottom) {
                Button {
                    selectedCategory = .willRead
                } label: {
                    CategoryButtonText(text: "Прочитаю", category: .willRead, selectedCategory: $selectedCategory)
                }
                
                Button {
                    selectedCategory = .didRead
                } label: {
                    CategoryButtonText(text: "Прочитал", category: .didRead, selectedCategory: $selectedCategory)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                if !booksForSelectedCategory.isEmpty {
                    ForEach(booksForSelectedCategory) { book in
                        BookItem(book: book, goToDetailsView: goToDetailsView)
                    }
                } else {
                    EmptyBooksView(title: "Список книг пуст", subtitle: "Попробуйте добавить пару новых книг", bookStyle: .booksVerticalFill)
                }
            }
        }
        .padding(.horizontal, 25)
    }
}

private struct CategoryButtonText: View {
    let text: String
    let category: BookStatus
    @Binding var selectedCategory: BookStatus
    
    private var isSelected: Bool {
        selectedCategory == category
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: isSelected ? 22 : 18, weight: isSelected ? .bold : .regular))
            .foregroundStyle(isSelected ? .white : .gray)
    }
}
