//
//  DetailsViewContent.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import SwiftUI


struct AddDetailsViewContent: View {
    var book: JsonBookModelItem
    @State var bookName: String = " "
    @ObservedObject var viewModel: AddDetailsViewModel
    var delegate: AddDetailsViewDelegate?
    
    init (book: JsonBookModelItem, delegate: AddDetailsViewDelegate?, viewModel: AddDetailsViewModel){
        self.book = book
        self._bookName = .init(initialValue: book.title ?? "Неизвестно")
        self.viewModel = viewModel
        self.delegate = delegate

    }
    var body: some View {
        VStack(spacing: 50) {
            NavigationHeader(title: book.title ?? "Неизвестно") {
                delegate?.back()
            }
            VStack(spacing: 30) {
                VStack(spacing: 20 ){
                    BookCover(coverId: book.cover_i?.description)
                        .scaledToFit()
                        .frame (width: 200, height: 270)
                        .clipShape(.rect(cornerRadius: 5))
                        .overlay(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                            Button{
                                //
                                
                            } label: {
                                ZStack{
                                    Circle()
                                        .foregroundStyle(.appGreen)
                                        .frame(width: 28, height: 28)
                                    Image(systemName:"arrow.triangle.2.circlepath")
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                        .foregroundStyle(.white)
                                }
                            }
                            .offset(x: 10, y: -10)
                        }
                    
                    VStack(spacing: 10){
                        BaseTextView(placeholder: "Название книги", text: $bookName)
                        TextEditorWithPlaceholder(text: $viewModel.bookDescription, placeholder: "Описание книги") {
                            delegate?.createText()
                        }
                    }
                }
                
                
                OrangeButton(title: "Добавить") {
                    delegate?.saveBook()
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 20)
            }
            
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment(horizontal: .leading, vertical: . top))
        .background(.mainBackground)

    }
}

#Preview {
    AddDetailsViewContent(book: JsonBookModelItem(author_name: ["Папа"], cover_i: 12, title: "STICK & STACK MOMONSTERS"), delegate: nil, viewModel: AddDetailsViewModel())
}
