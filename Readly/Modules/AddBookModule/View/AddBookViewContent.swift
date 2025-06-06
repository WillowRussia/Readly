//
//  DetailsViewContent.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import SwiftUI

struct AddBookViewContent: View {
    @State var bookName: String = ""
    @ObservedObject var loadingState: LoadingState
    let completion: (String?) -> ()
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            Color.mainBackground
                .ignoresSafeArea()
                .onTapGesture {
                  
                    isTextFieldFocused = false
                }
            
            VStack(spacing: 0) {
                NavigationHeader(title: "Добавить книгу") {
                    completion(nil)
                }
                Spacer()
                BaseTextView(placeholder: "Название книги", text: $bookName)
                    .focused($isTextFieldFocused)
                Spacer()
                OrangeButton(title: "Далее") {
                    completion(bookName)
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 30)
            .onChange(of: loadingState.isLoading) { isLoading in
                            if isLoading {
                                isTextFieldFocused = false
                            }
                        }
            
            if loadingState.isLoading {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                    .scaleEffect(2)
            }
        }
    }
}
