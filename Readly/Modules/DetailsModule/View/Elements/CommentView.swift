//
//  CommentView.swift
//  Readly
//
//  Created by Илья Востров on 07.04.2025.
//
import SwiftUI

struct CommentView: View {
    var note: Note
    var body: some View {
        VStack(alignment: .leading){
            Text(note.date.formatDate())
                .foregroundStyle(.white)
                .font (size: 12)
            Text(note.text)
        }
                .foregroundStyle(.appGray)
                .font(size: 13)
                .padding(.vertical, 12)
                .padding(.horizontal, 21)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.appDark)
                .clipShape(.rect(cornerRadius: 10))
            
    }
}
