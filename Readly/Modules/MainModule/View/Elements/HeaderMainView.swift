//
//  HeaderMainView.swift
//  Readly
//
//  Created by Илья Востров on 10.05.2025.
//

import SwiftUI

struct HeaderMainView: View {
    var name: String
    var addBookCompletion: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Добрый день")
                        .font(size: 14)
                    Text(name)
                        .font(type: .black, size: 16)
                }
                .foregroundStyle(.white)
                Spacer()
                Button {
                    addBookCompletion()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "book.closed")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 14, height: 14)
                        
                        Text("Добавить")
                            .font(type: .medium, size: 13)
                    }
                    .foregroundStyle(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 14)
                    .background(.appOrange)
                    .clipShape(Capsule())
                }
            }
        }
        .padding(.horizontal, 25)
    }
}
