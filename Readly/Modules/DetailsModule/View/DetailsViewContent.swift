//
//  DetailsViewContent.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import SwiftUI

struct DetailsViewContent: View {
    // 1. Используем один @ObservedObject для всех данных экрана.
    //    Я переименовал `bookWrapper` в `observableModel` для ясности.
    @ObservedObject var observableModel: DetailsObservableModel
    
    // 2. Упрощаем замыкания: Presenter уже знает, о какой книге идет речь.
    var onAddNote: (String) -> Void
    var onDeleteNote: (Note) -> Void
    var onStatusChange: (BookStatus) -> Void
    var onBack: () -> Void
    var onEdit: () -> Void
    var onDeleteBook: () -> Void

    // Все твои @State переменные остаются без изменений, они управляют UI.
    @State private var bookNote: String = ""
    @State private var commetDeleteOffsetX: CGFloat = 0
    @State private var swipedNoteId: String? = nil
    @State private var offsetTop: CGFloat = 0
    @State private var showTitle: Bool = false

    var body: some View {
        ZStack(alignment: .top) {
            HeaderDetailsView(
                book: observableModel.book,
                showTitle: showTitle,
                offsetTop: offsetTop,
                onBack: onBack,
                onEdit: onEdit,
                onDeleteBook: onDeleteBook
            )

            ScrollView(showsIndicators: false) {
                VStack(spacing: 29) {
                    BookHeader(
                        book: observableModel.book,
                        offsetTop: $offsetTop,
                        showTitle: $showTitle,
                        onStatusChange: onStatusChange
                    )

                    VStack(alignment: .leading, spacing: 36) {
                        DescriptionSection(book: observableModel.book)

                        NotesSection(
                            notes: observableModel.notes,
                            bookNote: $bookNote,
                            commetDeleteOffsetX: $commetDeleteOffsetX,
                            swipedNoteId: $swipedNoteId,
                            onAddNote: onAddNote,
                            onDeleteNote: onDeleteNote
                        )
                    }
                    .padding(.horizontal, 30)
                }
                .padding(.bottom, 30)
            }
        }
        .background(Color.mainBackground)
    }
}
