//
//  BookItem.swift
//  Readly
//
//  Created by Илья Востров on 07.04.2025.
//
import SwiftUI

struct BookItem: View {
    //var book: Book
    var body: some View {
        HStack(spacing: 13) {
            Image(.defaultCover)
                .resizable()
                .frame(width: 64, height: 94)
                .clipShape(.rect(cornerRadius: 3))
            
            VStack(alignment: .leading, spacing: 9) {
                
                VStack(alignment: .leading, spacing: 2) {
                    Text ("Моя жизнь")
                        .font(type: .bold, size: 14)
                    Text ("Илья Востров")
                        .font(type: .medium, size: 12)
                        .foregroundStyle(.appGray)
                }
                Text ("Очень важно описние, которое люди никогда не читают, потому что...")
                    .font(type: .medium, size: 14)
            }
            .foregroundStyle(.white)
        }
    }
}
