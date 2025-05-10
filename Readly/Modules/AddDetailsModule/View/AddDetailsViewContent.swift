//
//  DetailsViewContent.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import SwiftUI


struct AddDetailsViewContent: View {
    var book: JsonBookModelItem
    @State var bookName: String
    @State var bookAuthor: String
    @State var bookCover: UIImage = .defaultCover
    @State var isShowPicker = false
    @State var bookCoverType: ImageType
    @ObservedObject var viewModel: AddDetailsViewModel
    var delegate: AddDetailsViewDelegate?
    
    init (book: JsonBookModelItem, delegate: AddDetailsViewDelegate?, viewModel: AddDetailsViewModel){
        self.book = book
        self._bookName = .init(initialValue: book.title ?? "Неизвестно")
        self._bookAuthor = .init(initialValue: book.author_name?.authorsInOneLine() ?? "Неизвестно")
        self.viewModel = viewModel
        self.delegate = delegate
        self.bookCoverType = .network(book.cover_i?.description)
    }
    
    var body: some View {
        VStack(spacing: 50) {
            NavigationHeader(title: book.title ?? "Неизвестно") {
                delegate?.back()
            }
            VStack(spacing: 30) {
                VStack(spacing: 20 ){
                    BookCover(image: bookCoverType)
                        .scaledToFill()
                        .clipped()
                        .frame(width: 200, height: 270)
                        .clipShape(.rect(cornerRadius: 5))
                        .overlay(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                            Button{
                                isShowPicker.toggle()
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
                                .offset(x: 10, y: -10)
                            }
                            .sheet(isPresented: $isShowPicker) {
                                ImagePickerView(image: $bookCover)
                            }
                            
                        }
                        .onChange (of: bookCover) { newValue in
                            bookCoverType = .local(newValue)
                        }
                    
                    VStack(spacing: 10){
                        BaseTextView(placeholder: "Название книги", text: $bookName)
                        BaseTextView(placeholder: "Автор книги", text: $bookAuthor)
                        TextEditorWithPlaceholder(text: $viewModel.bookDescription, placeholder: "Описание книги") {
                            delegate?.createText()
                        }
                    }
                }
                
                
                OrangeButton(title: "Добавить") {
                    print(2)
                    delegate?.saveBook(imageType: bookCoverType, bookName: bookName, bookAuthor: bookAuthor, bookDescription: viewModel.bookDescription)
                }
                .disabled((viewModel.bookDescription.count < 3 || bookName.count < 3 || bookAuthor.count < 3) ? true : false)
                .opacity((viewModel.bookDescription.count < 3 || bookName.count < 3 || bookAuthor.count < 3) ? 0.5 : 1)
                
                
            }
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment(horizontal: .leading, vertical: . top))
        .background(.mainBackground)
        .alert(isPresented: $viewModel.isAddError) {
            Alert(title: Text ("Ошибка"),
                   message: Text ("0"), dismissButton: .default(Text("0K")))
        }
        
    }
}

#Preview {
    AddDetailsViewContent(book: JsonBookModelItem(author_name: ["Роберт", "Джейсон"], cover_i: 12, title: "STICK & STACK MOMONSTERS"), delegate: nil, viewModel: AddDetailsViewModel())
}
