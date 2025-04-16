//
//  BookListItem.swift
//  Readly
//
//  Created by Илья Востров on 16.04.2025.
//
import SwiftUI

struct BookListItem: View {
    var action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            HStack(alignment: .top, spacing: 13 ){
                Image(.testCover)
                    .resizable()
                    .frame(width: 100, height: 150)
                    .clipShape(.rect(cornerRadius: 3))
                VStack(alignment: .leading, spacing: 7 ) {
                    Text("Моя жизнь")
                        .foregroundStyle(.white)
                        .font(type: .black, size: 17)
                    Text("Илья Востров")
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
