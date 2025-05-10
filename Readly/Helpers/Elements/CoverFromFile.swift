//
//  CoverFromFile.swift
//  Readly
//
//  Created by Илья Востров on 09.05.2025.
//

import SwiftUI

struct CoverFromFile: View {
    var book: Book
    var body: some View {
        if let image = Image.from(folderName: book.id, fileName: "cover.jpeg") {
            image
                .resizable()
        } else {
            Image(.defaultCover)
                .resizable()
        }
    }
}
