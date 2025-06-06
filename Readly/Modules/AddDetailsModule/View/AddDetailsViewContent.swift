//
//  AddDetailsViewContent.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import SwiftUI


struct AddDetailsViewContent: View {
    let source: BookSource
    @State var bookName: String
    @State var bookAuthor: String
    @State var bookCover: UIImage = .defaultCover
    @State var isShowPicker = false
    @State var bookCoverType: ImageType
    @ObservedObject var viewModel: AddDetailsViewModel
    @FocusState private var focusedField: Field?
    var delegate: AddDetailsViewDelegate?
    
    init(source: BookSource, delegate: AddDetailsViewDelegate?, viewModel: AddDetailsViewModel) {
        self.source = source
        self.delegate = delegate
        self.viewModel = viewModel
        
        switch source {
        case .json(let jsonBook):
            _bookName = .init(initialValue: jsonBook.title ?? "Неизвестно")
            _bookAuthor = .init(initialValue: jsonBook.author_name?.authorsInOneLine() ?? "Неизвестно")
            bookCoverType = .network(jsonBook.cover_i?.description)
        case .coreData(let book):
            _bookName = .init(initialValue: book.name)
            _bookAuthor = .init(initialValue: book.author)
            if let data = StorageManager().getCover(bookId: book.id), let image = UIImage(data: data) {
                _bookCover = .init(initialValue: image)
                bookCoverType = .local(image)
            } else {
                bookCoverType = .local(.defaultCover)
            }
            viewModel.bookDescription = book.bookDescription
        }
    }
    
    
    var body: some View {
        
        Color.mainBackground
            .onTapGesture {
                hideKeyboard()
            }
        
        VStack(spacing: 40) {
            NavigationHeader(title: bookName) {
                delegate?.back()
            }
            .padding(.top, 26)
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
                            .focused($focusedField, equals: .bookName)
                        BaseTextView(placeholder: "Автор книги", text: $bookAuthor)
                            .focused($focusedField, equals: .bookAuthor)
                        TextEditorWithPlaceholder(text: $viewModel.bookDescription, placeholder: "Описание книги", viewModel: viewModel) {
                            delegate?.createText()
                        }
                    }
                }
                
                
                OrangeButton(title: "Сохранить") {
                    delegate?.saveBook(imageType: bookCoverType, bookName: bookName, bookAuthor: bookAuthor, bookDescription: viewModel.bookDescription)
                }
                .disabled((viewModel.bookDescription.count < 3 || bookName.count < 3 || bookAuthor.count < 3) ? true : false)
                .opacity((viewModel.bookDescription.count < 3 || bookName.count < 3 || bookAuthor.count < 3) ? 0.5 : 1)
                
                
            }
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment(horizontal: .leading, vertical: . top))
        .alert(isPresented: $viewModel.isAddError) {
            Alert(title: Text("Ошибка"),
                  message: Text("0"), dismissButton: .default(Text("0K")))
        }
        .onChange(of: viewModel.isAddError) { isError in
                    if isError {
                        hideKeyboard()
                    }
                }
    }
    private var isSaveButtonDisabled: Bool {
        viewModel.bookDescription.count < 3 || bookName.count < 3 || bookAuthor.count < 3
    }
    
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

enum BookSource {
    case json(JsonBookModelItem)
    case coreData(Book)
}

private enum Field {
    case bookName
    case bookAuthor
    case bookDescription
}
