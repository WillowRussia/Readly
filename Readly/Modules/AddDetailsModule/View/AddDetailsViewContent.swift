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
            VStack(spacing: 40) {
                NavigationHeader(title: bookName, action: onBack)
                    .padding(.top, 26)
                
                formContent
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.mainBackground.onTapGesture(perform: hideKeyboard))
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
        
        // MARK: - Subviews
        
        private var formContent: some View {
            ScrollView {
                VStack(spacing: 30) {
                    coverAndFieldsSection
                    
                    OrangeButton(title: "Сохранить", action: handleSaveChanges)
                        .disabled(isSaveButtonDisabled)
                        .opacity(isSaveButtonDisabled ? 0.5 : 1)
                }
            }
        }
        
        private var coverAndFieldsSection: some View {
            VStack(spacing: 20) {
                BookCoverView(imageType: bookCoverType)
                    .overlay(alignment: .topTrailing) {
                        ChangeCoverButton(isShowPicker: $isShowPicker)
                    }
                
                textFieldsSection
            }
        }
        
        private var textFieldsSection: some View {
            VStack(spacing: 10) {
                BaseTextView(placeholder: "Название книги", text: $bookName)
                    .focused($focusedField, equals: .bookName)
                BaseTextView(placeholder: "Автор книги", text: $bookAuthor)
                    .focused($focusedField, equals: .bookAuthor)
                TextEditorWithPlaceholder(text: $bookDescription, placeholder: "Описание книги", viewModel: observableModel, completion: onCreateText)
            }
        }
        
        // MARK: - Computed Properties & Methods
        
        private var isSaveButtonDisabled: Bool {
            bookName.count < 2 || bookAuthor.count < 2 || bookDescription.count < 10
        }
        
        private func handleSaveChanges() {
            hideKeyboard()
            let parameters = SaveBookParameters(
                source: source,
                imageType: bookCoverType,
                name: bookName,
                author: bookAuthor,
                description: bookDescription
            )
            onSave(parameters)
        }
        
        private func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }

    // MARK: - Private Helper Views

    private struct BookCoverView: View {
        let imageType: ImageType
        
        var body: some View {
            BookCover(image: imageType)
                .scaledToFill()
                .frame(width: 200, height: 270)
                .clipShape(.rect(cornerRadius: 5))
        }
    }

    private struct ChangeCoverButton: View {
        @Binding var isShowPicker: Bool
        
        var body: some View {
            Button {
                isShowPicker.toggle()
            } label: {
                ZStack {
                    Circle()
                        .foregroundStyle(Color.appGreen)
                        .frame(width: 28, height: 28)
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.white)
                }
                .offset(x: 10, y: -10)
            }
        }
    }

    // MARK: - Helper Enums

    private enum Field {
        case bookName, bookAuthor
    }
