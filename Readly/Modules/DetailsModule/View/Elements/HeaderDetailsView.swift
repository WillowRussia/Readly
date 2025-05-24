//
//  HeaderDetailsView.swift
//  Readly
//
//  Created by Илья Востров on 11.05.2025.
//

import SwiftUI

struct HeaderDetailsView: View {
    var book: Book
    var showTitle: Bool
    var offsetTop: CGFloat
    var onBack: () -> Void
    var onEditDescription: (Book) -> Void
    var onDeleteBook: (Book) -> Void
    
    @State private var showDeleteAlert = false
    @State private var showMenu = false
    var body: some View {
         HStack(spacing: 20) {
             Button(action: onBack) {
                 Image(systemName: "arrow.left")
                     .resizable()
                     .scaledToFill()
                     .foregroundStyle(.white)
                     .frame(width: 20, height: 24)
             }

             Spacer()

             Text(showTitle ? book.name : "О книге")
                 .font(size: 18)
                 .foregroundStyle(.white)

             Spacer()

             Menu {
                 Button("Редактировать описание") {
                     onEditDescription(book)
                 }
                 Button("Удалить книгу", role: .destructive) {
                     showDeleteAlert = true
                 }
             } label: {
                 Image(systemName: "ellipsis")
                     .resizable()
                     .scaledToFill()
                     .frame(width: 20, height: 5)
                     .rotationEffect(.degrees(90))
                     .foregroundStyle(.white)
                     .contentShape(Rectangle())
                     .padding(.vertical, 10)
             }
         }
         .padding(.top, 10)
         .padding(.horizontal, 30)
         .padding(.bottom, 15)
         .zIndex(1)
         .background(
             .mainBackground.opacity(offsetTop < 0 ? (-offsetTop * 5.3 / 1000) : 0)
         )
         .alert("Удалить книгу?", isPresented: $showDeleteAlert) {
             Button("Удалить", role: .destructive) {
                 onDeleteBook(book)
             }
             Button("Отмена", role: .cancel) {}
         } message: {
             Text("Это действие нельзя отменить.")
         }
     }
 }
