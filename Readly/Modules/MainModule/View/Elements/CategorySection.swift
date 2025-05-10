//
//  CategorySection.swift
//  Readly
//
//  Created by Илья Востров on 10.05.2025.
//

import SwiftUI

struct CategorySection: View {
    @Binding var selectedCategory: SelectedCategory
    
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
                    BookItem()
                    BookItem()
                }
            case .didRead:
                VStack {
                    BookItem()
                    BookItem()
                    BookItem()
                    BookItem()
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
