//
//  AddDetailsViewContent.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import SwiftUI

struct AddDetailsViewContent: View {
    
    // MARK: - Properties
    
    @State private var bookName: String
    @State private var bookAuthor: String
    @State private var bookDescription: String
    @State private var bookCoverType: ImageType
    
    @State private var isShowPicker = false
    @State private var selectedImage: UIImage?
    
    @ObservedObject var observableModel: AddDetailsObservableModel
    
    var onSave: (SaveBookParameters) -> Void
    var onBack: () -> Void
    var onCreateText: () -> Void
    
    @FocusState private var focusedField: Field?
    
    private let source: BookSource
    
    // MARK: - Initializer
    init(
        source: BookSource,
        initialViewModel: AddDetailsViewModel,
        observableModel: AddDetailsObservableModel,
        onSave: @escaping (SaveBookParameters) -> Void,
        onBack: @escaping () -> Void,
        onCreateText: @escaping () -> Void
    ) {
        self.source = source
        self.observableModel = observableModel
        self.onSave = onSave
        self.onBack = onBack
        self.onCreateText = onCreateText
        
        _bookName = .init(initialValue: initialViewModel.name)
        _bookAuthor = .init(initialValue: initialViewModel.author)
        _bookDescription = .init(initialValue: initialViewModel.description)
        _bookCoverType = .init(initialValue: .local(initialViewModel.coverImage))
    }
    
    // MARK: - Body

    var body: some View {
        ZStack {
            Color.mainBackground
                .edgesIgnoringSafeArea(.all)
                .onTapGesture(perform: hideKeyboard)
            
            VStack(spacing: 0) {
                NavigationHeader(title: bookName, action: onBack)
                    .padding(.horizontal, 30)
                    .padding(.top, 26)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        contentForm
                    }
                    .padding(.top, 40)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                }
            }
        }
        .sheet(isPresented: $isShowPicker) {
            ImagePickerView(image: $selectedImage)
        }
        .onChange(of: selectedImage) { newImage in
            if let newImage = newImage {
                self.bookCoverType = .local(newImage)
            }
        }
        .onChange(of: observableModel.bookDescription) { newDescription in
            self.bookDescription = newDescription
        }
    }

    private var contentForm: some View {
        VStack(spacing: 30) {
            VStack(spacing: 20) {
                coverSection
                fieldsSection
            }
            saveButton
        }
    }

    private var coverSection: some View {
        BookCover(image: bookCoverType)
            .scaledToFill().frame(width: 200, height: 270).clipShape(.rect(cornerRadius: 5))
            .overlay(alignment: .topTrailing) {
                Button(action: { isShowPicker.toggle() }) {
                    ZStack {
                        Circle().foregroundStyle(.appGreen).frame(width: 28)
                        Image(systemName:"arrow.triangle.2.circlepath").resizable().frame(width: 16, height: 16).foregroundStyle(.white)
                    }.offset(x: 10, y: -10)
                }
            }
    }
    
    private var fieldsSection: some View {
        VStack(spacing: 10) {
            BaseTextView(placeholder: "Название книги", text: $bookName)
                .focused($focusedField, equals: .bookName)
            BaseTextView(placeholder: "Автор книги", text: $bookAuthor)
                .focused($focusedField, equals: .bookAuthor)
            
            TextEditorWithPlaceholder(text: $bookDescription, placeholder: "Описание книги", viewModel: observableModel, completion: onCreateText)
        }
    }
    
    private var saveButton: some View {
        OrangeButton(title: "Сохранить", action: handleSaveChanges)
            .disabled(isSaveButtonDisabled)
            .opacity(isSaveButtonDisabled ? 0.5 : 1)
    }
    
    private var isSaveButtonDisabled: Bool {
        bookName.count < 3 || bookAuthor.count < 3 || observableModel.bookDescription.count < 3 || observableModel.isLoading
    }

    private func handleSaveChanges() {
        hideKeyboard()
        let parameters = SaveBookParameters(
            source: source,
            imageType: bookCoverType,
            name: bookName,
            author: bookAuthor,
            description: observableModel.bookDescription
        )
        onSave(parameters)
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

}

// MARK: - Helper Enums
private enum Field {
    case bookName, bookAuthor
}
