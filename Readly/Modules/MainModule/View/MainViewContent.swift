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
    var addBookCompletion: () -> ()
    var body: some View {
        ZStack(alignment: .top ){
            //MARK: Header
            VStack(alignment: .leading) {
                HStack{
                    VStack(alignment: .leading, spacing: 5) {
                        Text ("Добрый день")
                            .font(size: 14)
                        Text(name)
                            .font(type: .black, size: 16)
                    }
                    .foregroundStyle(.white)
                    Spacer()
                    Button {
                        addBookCompletion()
                    } label: {
                        HStack(spacing: 10){
                            Image (systemName: "book.closed")
                                .resizable ()
                                .scaledToFill()
                                .frame(width: 14, height: 14)
                            
                            Text("Добавить")
                                .font(type: .medium, size: 13)
                        }
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                        .padding (.horizontal, 14)
                        .background(.appOrange)
                        .clipShape(Capsule())
                    }
                }
            }
            .padding (.horizontal, 25)
            .zIndex(9)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    // MARK: Read
                    VStack(alignment: .leading, spacing: 25) {
                        BaseTextView(placeholder: "Поиск", text: $searchField)
                            .font()
                            .padding(.horizontal, 25)
                        
                        //MARK: Body
                        VStack(alignment: .leading, spacing: 18) {
                            Text("Читаю")
                                .font(type: .bold, size: 22)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 25)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20 ){
                                    Button {
                                    } label: {
                                        Image(.defaultCover)
                                            .resizable()
                                            .frame(width: 143, height: 212)
                                            .clipShape(.rect(cornerRadius: 5))
                                    }
                                    
                                    Button {
                                    } label: {
                                        Image(.defaultCover)
                                            .resizable()
                                            .frame(width: 143, height: 212)
                                            .clipShape(.rect(cornerRadius: 5))
                                    }
                                    
                                    Button {
                                    } label: {
                                        Image(.defaultCover)
                                            .resizable()
                                            .frame(width: 143, height: 212)
                                            .clipShape(.rect(cornerRadius: 5))
                                    }
                                }
                                .padding(.horizontal, 25)
                            }
                        }
                    }
                    // MARK: Category
                    VStack(alignment: .leading, spacing: 26){
                        HStack(alignment: .bottom){
                            Button {
                                selectedCategory = .willRead
                            } label: {
                                createButtonText(text: "Прочитаю", category: .willRead)
                            }
                            
                            Button {
                                selectedCategory = .didRead
                            } label: {
                                createButtonText(text: "Прочитал", category: .didRead)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        switch selectedCategory {
                        case .willRead:
                            VStack{
                                BookItem()
                                BookItem()
                            }
                        case .didRead:
                            VStack{
                                BookItem()
                                BookItem()
                                BookItem()
                                BookItem()
                            }
                        }
                        
                        }
                    .padding(.horizontal, 25)
                    
                    
                    
                }
            }
            .padding(.top, 80)
            .background(Color.mainBackground)
        }
    }
    
    @ViewBuilder
    func createButtonText(text: String, category: SelectedCategory) -> some View {
        let condition = selectedCategory == category
        Text(text)
            .font(type: condition ? .bold : .regular, size: condition ? 22 : 18)
            .foregroundStyle(condition ? .white : .appGray)
    }
}

enum SelectedCategory {
    case willRead
    case didRead
}

#Preview {
    MainViewContent(name: "Ilya") {
        print("Hello world!")
    }
}
