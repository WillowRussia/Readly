//
//  BookCover.swift
//  Readly
//
//  Created by Илья Востров on 21.04.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookCover: View {
    var coverId: String?
    var body: some View {
        if let coverId, let url = URL(string: "https://covers.openlibrary.org/b/id/\(coverId)-L.jpg"){
            WebImage (url: url)
                .resizable()
        } else {
            Image(.defaultCover)
                .resizable()
        }
    }
}
