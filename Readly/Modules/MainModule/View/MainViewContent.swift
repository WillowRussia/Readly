//
//  MainViewContent.swift
//  Readly
//
//  Created by Илья Востров on 09.03.2025.
//

import SwiftUI

struct MainViewContent: View {
    @State var searchField = ""
    @State private var selectedCategory: SelectedCategory = .willRead
    var name: String
    @ObservedObject var viewModel: MainViewModel
    var addBookCompletion: () -> Void
    var goToDetailsView: (Book) -> Void
    
    var body: some View {
        ZStack(alignment: .top) {
            // MARK: Header
            HeaderMainView(name: name, addBookCompletion: addBookCompletion)
                .zIndex(9)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    // MARK: Read
                    ReadingSection(books: viewModel.books[BookStatus.read] ?? [], goToDetailsView: goToDetailsView)

                    // MARK: Category
                    CategorySection(selectedCategory: $selectedCategory, viewModel: viewModel, goToDetailsView: goToDetailsView)
                }
            }
            .padding(.top, 80)
            .background(Color.mainBackground)
        }
    }
}





