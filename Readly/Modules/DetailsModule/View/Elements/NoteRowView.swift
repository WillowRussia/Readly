//
//  NoteRowView.swift
//  Readly
//
//  Created by Илья Востров on 11.05.2025.
//

import SwiftUI

struct NoteRowView: View {
    var note: Note
    @Binding var swipedNoteId: String?
    @Binding var commetDeleteOffsetX: CGFloat
    @State private var showDeleteAlert = false
    var onDeleteNote: (Note) -> Void

    var body: some View {
        ZStack(alignment: .trailing) {
            CommentView(note: note)
                .offset(x: swipedNoteId == note.id ? -commetDeleteOffsetX : 0)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.width < -commetDeleteOffsetX {
                                swipedNoteId = note.id
                                commetDeleteOffsetX = min(abs(value.translation.width), 150)
                            }
                        }
                        .onEnded { value in
                            if value.translation.width < -100 {
                                showDeleteAlert = true
                            } else {
                                withAnimation {
                                    swipedNoteId = nil
                                    commetDeleteOffsetX = 0
                                }
                            }
                        }
                )

            Button {
                showDeleteAlert = true
            } label: {
                Image(systemName: "trash.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.white)
                    .opacity(swipedNoteId == note.id && commetDeleteOffsetX > 0 ? (commetDeleteOffsetX/100) : 0)
                    .padding(.trailing, 40)
            }
        }
        .alert("Удалить заметку?", isPresented: $showDeleteAlert) {
            Button("Удалить", role: .destructive) {
                withAnimation {
                    onDeleteNote(note)
                }
            }
            Button("Отмена", role: .cancel) {
                withAnimation {
                    swipedNoteId = nil
                    commetDeleteOffsetX = 0
                }
            }
        } message: {
            Text("Это действие нельзя отменить.")
        }
    }
}
