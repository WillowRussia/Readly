//
//  MainViewContent.swift
//  Readly
//
//  Created by Илья Востров on 09.03.2025.
//

import SwiftUI

struct MainViewContent: View {
    
    @State private var selectedCategory: BookStatus = .willRead
    
    @ObservedObject var viewModel: MainViewObservableModel
    
    var addBookCompletion: () -> Void
    var goToDetailsView: (Book) -> Void
    
    var body: some View {
        ZStack(alignment: .top) {
            // MARK: Header
            HeaderMainView(name: viewModel.userName, addBookCompletion: addBookCompletion)
                .zIndex(9)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    // MARK: Read
                    ReadingSection(books: viewModel.booksByStatus[.read] ?? [], goToDetailsView: goToDetailsView)

                    // MARK: Category
                    CategorySection(selectedCategory: $selectedCategory, viewModel: viewModel, goToDetailsView: goToDetailsView)
                }
            }
            .padding(.top, 80)
            .background(Color.mainBackground)
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}




