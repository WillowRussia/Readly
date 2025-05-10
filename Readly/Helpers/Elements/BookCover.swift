//
//  BookCover.swift
//  Readly
//
//  Created by Илья Востров on 21.04.2025.
//

import SwiftUI
import SDWebImageSwiftUI

enum ImageType {
    case local(UIImage)
    case network(String?)
}

struct BookCover: View {
    var image: ImageType
    
    var body: some View {
        switch image {
        case .local(let image):
            Image(uiImage: image)
                .resizable()
        case .network(let coverId):
            if let coverId, let url = URL(string: "https://covers.openlibrary.org/b/id/\(coverId)-L.jpg"){
                WebImage(url: url)
                    .resizable()
            } else {
                Image(.defaultCover)
                    .resizable()
            }
        }
    }
}
