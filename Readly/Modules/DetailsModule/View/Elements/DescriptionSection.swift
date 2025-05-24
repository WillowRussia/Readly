//
//  DescriptionSection.swift
//  Readly
//
//  Created by Илья Востров on 11.05.2025.
//

import SwiftUI

struct DescriptionSection: View {
    var book: Book

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Описание")
                .font(type: .black, size: 18)
                .foregroundStyle(.white)

            Text(book.bookDescription)
                .font(size: 14)
                .foregroundStyle(.appGray)
        }
    }
}
