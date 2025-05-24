//
//  DetailsViewContent.swift
//  Readly
//
//  Created by Илья Востров on 05.04.2025.
//

import SwiftUI

struct DetailsViewContent: View {
    @State var book: Book
    var notes: [Note]
    var onAddNote: (String) -> Void
    var onDeleteNote: (Note) -> Void
    var onStatusChange: (BookStatus) -> Void
    var onBack: () -> Void
    var onEditDescription: (Book) -> Void
    var onDeleteBook: (Book) -> Void

    @State private var bookNote: String = ""
    @State private var commetDeleteOffsetX: CGFloat = 0
    @State private var swipedNoteId: String? = nil
    @State private var offsetTop: CGFloat = 0
    @State private var showTitle: Bool = false

    var body: some View {
        ZStack(alignment: .top) {
            HeaderDetailsView(book: book, showTitle: showTitle, offsetTop: offsetTop, onBack: onBack, onEditDescription: onEditDescription, onDeleteBook: onDeleteBook)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 29) {
                    BookHeader(book: book, offsetTop: $offsetTop, showTitle: $showTitle, onStatusChange: onStatusChange)

                    VStack(alignment: .leading, spacing: 36) {
                        DescriptionSection(book: book)

                        NotesSection(
                            notes: notes,
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
        .background(.mainBackground)


    }


}
