//
//  Image.ext.swift
//  Readly
//
//  Created by Илья Востров on 09.05.2025.
//

import SwiftUI

extension Image {
    static func from(folderName: String, fileName: String) -> Image? {
        let fileManager = FileManager.default
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        
        let fileURL = directory.appendingPathComponent(folderName).appendingPathComponent(fileName)
        
        guard fileManager.fileExists(atPath: fileURL.path),
              let uiImage = UIImage(contentsOfFile: fileURL.path) else { return nil }
        return Image(uiImage: uiImage)
    }
}
