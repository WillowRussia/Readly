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

    var body: some View {
        ZStack {
            VStack {
                NavigationHeader(title: "Добавить книгу") {
                    completion(nil)
                }
                Spacer()
                BaseTextView(placeholder: "Название книги", text: $bookName)
                Spacer()
                OrangeButton(title: "Далее") {
                    completion(bookName)
                }
            }
            .padding(.horizontal, 30)
            .background(.mainBackground)

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
