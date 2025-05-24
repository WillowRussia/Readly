//
//  NotesSection.swift
//  Readly
//
//  Created by Илья Востров on 11.05.2025.
//

import SwiftUI

struct NotesSection: View {
    var notes: [Note]
    @Binding var bookNote: String
    @Binding var commetDeleteOffsetX: CGFloat
    @Binding var swipedNoteId: String?
    
    var onAddNote: (String) -> Void
    var onDeleteNote: (Note) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Заметки по книге")
                .font(type: .bold, size: 18)
                .foregroundStyle(.white)
            
            ForEach(notes, id: \.id) { note in
                NoteRowView(
                    note: note,
                    swipedNoteId: $swipedNoteId,
                    commetDeleteOffsetX: $commetDeleteOffsetX,
                    onDeleteNote: onDeleteNote
                )
            }
            NoteEditorView(placeholder: "Добавить заметку", text: $bookNote)
            
            OrangeButton(title: "Сохранить заметку") {
                guard !bookNote.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                onAddNote(bookNote)
                bookNote = ""
            }
            .padding(.top, 5)
            .opacity(bookNote.isEmpty ? 0 : 1)
        }
    }
}
