//
//  DetailsViewContent.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import SwiftUI

struct AddBookViewContent: View {
    @State var bookName: String = ""
    let completion: (String?) -> ()
    var body: some View {
        VStack( ){
            
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 30)
        .background (.mainBackground)
    }
}
