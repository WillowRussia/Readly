//
//  EmptyBooksView.swift
//  Readly
//
//  Created by Илья Востров on 22.04.2025.
//
import SwiftUI

struct EmptyBooksView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "books.vertical.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.gray)
                .opacity(0.6)
            
        
            Text("Книг не найдено")
                .font(type: .bold, size: 25)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Text("Попробуйте изменить текст запроса.")
                .font(size: 16)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mainBackground)
    }
}
