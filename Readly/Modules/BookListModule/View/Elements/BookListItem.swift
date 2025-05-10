//
//  BookListItem.swift
//  Readly
//
//  Created by Илья Востров on 16.04.2025.
//
import SwiftUI

struct BookListItem: View {
    let book: JsonBookModelItem
    var action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            HStack(alignment: .top, spacing: 13 ){
                BookCover(image: .network(book.cover_i?.description))
                    .scaledToFit()
                    .frame(width: 80, height: 120)
                    .clipShape(.rect(cornerRadius: 3))
                VStack(alignment: .leading, spacing: 7 ) {
                    Text(book.title ?? "Отсуствует")
                        .foregroundStyle(.white)
                        .font(type: .black, size: 17)
                    Text(book.author_name?.authorsInOneLine() ?? "Отсуствует")
                        .foregroundStyle(.appGray)
                        .font(type: .medium, size: 15)
                }
                .padding(.top, 10)
                    Spacer()
                Image(systemName:"chevron.right")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(.white)
                    .frame(width: 15, height: 15)
                    .padding(.top, 20)
            }
        }
    }
}
