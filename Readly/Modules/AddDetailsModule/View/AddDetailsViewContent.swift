//
//  DetailsViewContent.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import SwiftUI

struct AddDetailsViewContent: View {
    @State var bookName: String = ""
    @State var bookDescription: String = ""
    var body: some View {
        VStack(spacing: 60) {
            NavigationHeader(title: "Моя жизнь") {
                //
            }
            VStack(spacing: 80) {
                Image(.testCover)
                    .resizable()
                    .scaledToFill()
                    .frame (width: 130, height: 180)
                    .clipShape(.rect(cornerRadius: 5))
                    .overlay(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                        Button{
                        } label:{
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
                
                VStack(spacing: 30){
                    BaseTextView(placeholder: "Название книги", text: $bookName)
                    TextEditorWithPlaceholder(text: $bookDescription, placeholder: "Описание книги")
                }
                
                Spacer()
                
                OrangeButton(title: "Добавить") {
                    //
                }
            }
            
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment(horizontal: .leading, vertical: . top))
        .background(.mainBackground)

    }
}


#Preview {
    AddDetailsViewContent()
}
